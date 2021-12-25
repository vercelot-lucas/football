//
//  KeyedDecodingContainer+Cast.swift
//  Sports_Entities
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

extension KeyedDecodingContainer {
    
    func decodeFailableObject<T>(_ type: T.Type, forKey key: K) -> T? where T: Decodable {
        let object = try? decodeIfPresent(FailableDecodable<T>.self, forKey: key)
        return object?.base
    }
    
    // MARK: - Array
    
    public func decodeFailableObjectsIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key)  throws -> [T]? where T: Decodable {
        guard let objects = try decodeIfPresent([FailableDecodable<T>].self, forKey: key) else {
            return nil
        }
        return objects.compactMap { $0.base }
    }
}
