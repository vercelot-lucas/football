//
//  SportsClubDetailPresenter.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class SportsClubDetailPresenter {
    
    private weak var displayer: SportsClubDetailDisplayable?
    
    init(displayer: SportsClubDetailDisplayable) {
        self.displayer = displayer
    }
}

// MARK: - Interactor -> Presenter

extension SportsClubDetailPresenter: SportsClubDetailPresentable {
    
    func presentSportsClub(with response: SportsClubDetailModels.Response) {
        displayer?.displaySportsClub(with: SportsClubDetailModels.ViewModel(sportClub: response.sportClub))
    }
}
