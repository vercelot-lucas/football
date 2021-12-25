//
//  SportsClubsListInterfaces.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import Sports_Entities

// MARK: - View Controller

protocol SportsClubsListDisplayable: AnyObject {
    func displaySportsClubs(with viewModel: SportsClubsListModels.ViewModel)
    func displayAutoCompletionLeagues(with viewModel: SportsClubsListModels.ViewModel)
}

// MARK: - Interactor

protocol SportsClubsListInteractable {
    func loadSportsClubs(fromLeague leagueName: String)
    func loadAutoCompletionLeagues(from searchText: String)
}

// MARK: - Presenter

protocol SportsClubsListPresentable {
    func presentSportsClubs(with response: SportsClubsListModels.Response)
    func presentAutoCompletionLeagues(with response: SportsClubsListModels.Response)
}

// MARK: - Router

protocol SportsClubsListRoutable {
    func showSportClubDetail(for sportClub: SportClub)
}
