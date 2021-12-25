//
//  SportsClubsListModels.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import Sports_Entities

enum SportsClubsListModels {
    
    // MARK: - Interactor -> Presenter
    
    struct Response {
        let sportClubs: [SportClub]
        let autoCompletionLeagues: [League]
    }
    
    // MARK: - Presenter -> ViewController
    
    struct ViewModel {
        let sportClubs: [SportClub]
        let autoCompletionLeagues: [League]
    }
}
