//
//  RoutedViewController.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import UIKit
import Foundation

protocol RoutedViewController where Self: UIViewController {
    var router: Router? { get }
}
