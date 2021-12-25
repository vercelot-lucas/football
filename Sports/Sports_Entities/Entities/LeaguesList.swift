//
//  LeaguesList.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import Foundation

public struct LeaguesList: Decodable {
    public let leagues: [League]
}

private extension LeaguesList {
    private enum CodingKeys: String, CodingKey {
        case leagues = "leagues"
    }
}

public extension LeaguesList {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        leagues = try values.decodeFailableObjectsIfPresent(League.self, forKey: .leagues) ?? []
    }
}
