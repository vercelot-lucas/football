//
//  SportsClubsListPresenter.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class SportsClubsListPresenter {
    
    private weak var displayer: SportsClubsListDisplayable?
    
    init(displayer: SportsClubsListDisplayable) {
        self.displayer = displayer
    }
}

// MARK: - Interactor -> Presenter

extension SportsClubsListPresenter: SportsClubsListPresentable {
    
    func presentSportsClubs(with response: SportsClubsListModels.Response) {
        displayer?.displaySportsClubs(with: SportsClubsListModels.ViewModel(sportClubs: response.sportClubs,
                                                                            autoCompletionLeagues: response.autoCompletionLeagues))
    }
    
    func presentAutoCompletionLeagues(with response: SportsClubsListModels.Response) {
        displayer?.displayAutoCompletionLeagues(with: SportsClubsListModels.ViewModel(sportClubs: response.sportClubs,
                                                                                      autoCompletionLeagues: response.autoCompletionLeagues))
    }
}
