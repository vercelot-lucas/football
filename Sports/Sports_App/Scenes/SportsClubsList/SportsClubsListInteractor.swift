//
//  SportsClubsListInteractor.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class SportsClubsListInteractor {
    
    // MARK: - Dependencies
    
    private let presenter: SportsClubsListPresentable
    private let networkClient: NetworkClient
    private let autoCompletionFilterer: AutocompletionFilterer
    
    // MARK: - Init
    
    init(presenter: SportsClubsListPresentable,
         networkclient: NetworkClient = NetworkClientImpl.shared,
         autoCompletionFilterer: AutocompletionFilterer = AutocompletionFilterer()) {
        self.presenter = presenter
        self.networkClient = networkclient
        self.autoCompletionFilterer = autoCompletionFilterer
    }
}

// MARK: - ViewController -> Interactor

extension SportsClubsListInteractor: SportsClubsListInteractable {
    
    func loadSportsClubs(fromLeague leagueName: String) {
        networkClient.searchSportsClubs(searchText: leagueName) { [weak self] teams in
            guard let self = self else { return }
            
            self.presenter.presentSportsClubs(with: SportsClubsListModels.Response(sportClubs: teams?.sportsClubs ?? [], autoCompletionLeagues: []))
        }
    }
    
    func loadAutoCompletionLeagues(from searchText: String) {
        let autoCompletionLeagues = autoCompletionFilterer.filterLeagues(basedOn: searchText)
        presenter.presentAutoCompletionLeagues(with: SportsClubsListModels.Response(sportClubs: [], autoCompletionLeagues: autoCompletionLeagues))
    }
}
