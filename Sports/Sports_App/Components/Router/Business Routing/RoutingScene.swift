//
//  RoutingScene.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import Sports_Entities

extension Routing {
    
    /// Describes all scenes (mostly view controllers) of the application, and their required parameters if any.
    enum Scene: Equatable {

        case sportsClubsList
        case sportsClubDetail(searchSportsClubName: String)
    }
}
