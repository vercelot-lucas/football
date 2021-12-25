//
//  RoutingScene+UIViewController.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit

extension Routing.Scene {
    
    /// Instanciate the corresponding ViewController of the scene.
    func asViewController() -> UIViewController & RoutedViewController {
        switch self {
        case .sportsClubsList:
            return SportsClubsListViewController()
        case let .sportsClubDetail(searchSportsClubName):
            let sportsClubDetailViewController = SportsClubDetailViewController()
            sportsClubDetailViewController.searchSportsClubName = searchSportsClubName
            return sportsClubDetailViewController
        }
    }
}
