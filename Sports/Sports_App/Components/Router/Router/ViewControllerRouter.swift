//
//  ViewControllerRouter.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit

class ViewControllerRouter: BaseRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Hide
    
    override func hideChildren() {
        
        if viewController?.presentedViewController != nil {
            viewController?.dismiss(animated: true, completion: nil)
        }
        
        if let viewController = viewController, viewController.navigationController?.viewControllers.contains(viewController) == true {
            viewController.navigationController?.popToViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Base ViewController's Execute
    
    override func execute(step: Routing.Step) -> Bool {
        switch step {
        case let .push(scene):
            show(scene: scene)
            return true
        case let .present(scene):
            present(scene: scene)
            return true
        }
    }
    
    // MARK: - Generic show & present
    
    func show(scene: Routing.Scene) {
        let nextViewController = scene.asViewController()
        viewController?.show(nextViewController, sender: nil)
        currentChild = nextViewController.router
    }
    
    func present(scene: Routing.Scene,
                 inNavigationStack embedded: Bool = false) {
        let nextViewController = scene.asViewController()
        present(nextViewController,
                inNavigationStack: embedded)
    }
    
    private func present(_ nextViewController: UIViewController & RoutedViewController,
                         inNavigationStack embedded: Bool = false) {
        
        let viewControllerToPresent = embedded ? UINavigationController(rootViewController: nextViewController): nextViewController
        
        viewController?.present(viewControllerToPresent, animated: true, completion: nil)
        currentChild = nextViewController.router
    }
}
