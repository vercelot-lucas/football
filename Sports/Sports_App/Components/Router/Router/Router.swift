//
//  Router.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

/// Namespace for encapsuling all Router stuff
enum Routing {}

protocol Router: AnyObject {
    var currentChild: Router? { get }
    
    func hideChildren()
    
    func handle(steps: [Routing.Step])
}
