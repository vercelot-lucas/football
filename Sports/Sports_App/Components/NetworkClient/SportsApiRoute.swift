//
//  SportsApiRoute.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class SportsApiRoute {
    
    private let action: SportsApiAction
    
    required init(action: SportsApiAction) {
        self.action = action
    }
    
    enum HTTPMethod: String {
        case get
    }
    
    var method: HTTPMethod {
        switch action {
        case .searchAllTeams, .searchSpecificTeam, .getAllLeagues:
            return .get
        }
    }
    
    var endpoint: String? {
        switch action {
        case let .searchAllTeams(searchText):
            guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
            return "search_all_teams.php?l=\(encodedSearchText)"
        case let .searchSpecificTeam(team):
            guard let encodedTeamString = team.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
            return "searchteams.php?t=\(encodedTeamString)"
        case .getAllLeagues:
            return "all_leagues.php"
        }
    }
    
    var responseTimeout: TimeInterval {
        return 5.0
    }
}
