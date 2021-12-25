//
//  League.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import Foundation

public struct League: Decodable {
    public let id: String
    public let name: String
}

private extension League {
    private enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
    }
}

public extension League {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}

// MARK: - Equatable

extension League: Equatable {}
