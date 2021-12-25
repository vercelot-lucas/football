//
//  AutocompletionFilterer.swift
//  Sports
//
//  Created by Lucas VERCELOT on 25/12/2021.
//

import Foundation
import Sports_Entities

class AutocompletionFilterer {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClientImpl.shared) {
        self.networkClient = networkClient
    }
    
    func filterLeagues(basedOn searchString: String) -> [League] {
        return networkClient.leagues.filter { $0.name.lowercased().contains(searchString.lowercased()) }
    }
}
