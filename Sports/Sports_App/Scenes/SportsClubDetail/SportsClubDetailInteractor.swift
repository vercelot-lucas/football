//
//  SportsClubDetailInteractor.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class SportsClubDetailInteractor {
    
    // MARK: - Dependencies
    
    private let presenter: SportsClubDetailPresentable
    private let networkClient: NetworkClient

    // MARK: - Init
    
    init(presenter: SportsClubDetailPresentable,
         networkclient: NetworkClient = NetworkClientImpl.shared) {
        self.presenter = presenter
        self.networkClient = networkclient
    }
}

// MARK: - ViewController -> Interactor

extension SportsClubDetailInteractor: SportsClubDetailInteractable {
    
    func load(searchedSportsClubName: String) {
        networkClient.searchSpecificClub(team: searchedSportsClubName) { [weak self] teams in
            guard let sportClub = teams?.sportsClubs.first else {
                return
            }
            self?.presenter.presentSportsClub(with: SportsClubDetailModels.Response(sportClub: sportClub))
        }
    }
}
