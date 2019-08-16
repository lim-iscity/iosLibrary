//
//  main.swift
//  iosLibrary
//
//  Created by Lim Thean Khoon on 16/08/2019.
//  Copyright © 2019 Lim Thean Khoon. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
let _ = UIApplicationMain(CommandLine.argc, args, nil, appDelegateClass)
