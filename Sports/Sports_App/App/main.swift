//
//  main.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import UIKit

/**
 Custom main file to launch the regular AppDelegate if not unit testing.
 It allows us to avoid to lauch the AppDelegate when unit testing, gain lot of time,
 and makes us sure that unit tests are not coupled with any stuff done by the AppDelegate.
 */

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
