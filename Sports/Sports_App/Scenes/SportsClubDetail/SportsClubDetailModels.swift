//
//  SportsClubDetailModels.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import Sports_Entities

enum SportsClubDetailModels {
    
    // MARK: - Interactor -> Presenter
    
    struct Response {
        let sportClub: SportClub
    }
    
    // MARK: - Presenter -> ViewController
    
    struct ViewModel {
        let sportClub: SportClub
    }
}
