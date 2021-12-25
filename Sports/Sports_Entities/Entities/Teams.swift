//
//  Teams.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

public struct Teams: Decodable {
    public let sportsClubs: [SportClub]
}

private extension Teams {
    private enum CodingKeys: String, CodingKey {
        case sportsClubs = "teams"
    }
}

public extension Teams {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sportsClubs = try values.decodeFailableObjectsIfPresent(SportClub.self, forKey: .sportsClubs) ?? []
    }
}
