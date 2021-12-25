//
//  SportsClubDetailInterfaces.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

// MARK: - View Controller

protocol SportsClubDetailDisplayable: AnyObject {
    func displaySportsClub(with viewModel: SportsClubDetailModels.ViewModel)
}

// MARK: - Interactor

protocol SportsClubDetailInteractable {
    func load(searchedSportsClubName: String)
}

// MARK: - Presenter

protocol SportsClubDetailPresentable {
    func presentSportsClub(with response: SportsClubDetailModels.Response)
}

// MARK: - Router

protocol SportsClubDetailRoutable {
}
