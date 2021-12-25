//
//  SportsClubsListRouter.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit
import Sports_Entities

class SportsClubsListRouter: ViewControllerRouter {}

// MARK: - ViewController -> Router

extension SportsClubsListRouter: SportsClubsListRoutable {
    
    func showSportClubDetail(for sportClub: SportClub) {
        present(scene: .sportsClubDetail(searchSportsClubName: sportClub.name))
    }
}
