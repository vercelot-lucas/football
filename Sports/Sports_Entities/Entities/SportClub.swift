//
//  SportClub.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

public struct SportClub: Decodable {
    public let id: String
    public let name: String
    public let description: String?
    public let league: String?
    public let country: String?
    public let stadium: String?
    public let badgeImageURL: URL
    public let bannerImageURL: URL?
}

private extension SportClub {
    private enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case description = "strDescriptionFR"
        case league = "strLeague"
        case country = "strCountry"
        case stadium = "strStadium"
        case badgeImageURL = "strTeamBadge"
        case bannerImageURL = "strTeamBanner"
    }
}

public extension SportClub {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = values.decodeFailableObject(String.self, forKey: .description)
        league = values.decodeFailableObject(String.self, forKey: .league)
        country = values.decodeFailableObject(String.self, forKey: .country)
        stadium = values.decodeFailableObject(String.self, forKey: .stadium)
        badgeImageURL = try values.decode(URL.self, forKey: .badgeImageURL)
        bannerImageURL = values.decodeFailableObject(URL.self, forKey: .bannerImageURL)
    }
}

// MARK: - Equatable

extension SportClub: Equatable {}
