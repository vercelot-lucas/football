//
//  SportsApiAction.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

enum SportsApiAction {
    case searchAllTeams(_ searchText: String)
    case searchSpecificTeam(_ team:  String)
    case getAllLeagues
}
