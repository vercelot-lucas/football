//
//  RoutingStep.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

extension Routing {
    
    /// A Step is a business rule composing a deeplink.
    enum  Step {
        // Controllers
        case push(scene: Routing.Scene)
        case present(scene: Routing.Scene)
    }
}
