//
//  FailableDecodable.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

struct FailableDecodable<Base: Decodable> : Decodable {
    
    let base: Base?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
