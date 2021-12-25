//
//  BaseRouter.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation

class BaseRouter: Router {
    weak var currentChild: Router?
    
    func hideChildren() {}
    
    func handle(steps: [Routing.Step]) {
        let remainingSteps = steps.execute { step in
            execute(step: step)
        }
        currentChild?.handle(steps: remainingSteps)
    }
    
    func execute(step: Routing.Step) -> Bool {
        return false
    }
}

private extension Array where Element == Routing.Step {
    func execute(handle: (Element) -> Bool) -> [Element] {
        var remainingSteps = [Element]()
        
        forEach {
            if handle($0) == false {
                remainingSteps.append($0)
            }
        }
        
        return remainingSteps
    }
}
