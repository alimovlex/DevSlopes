//
//  AppDelegate.swift
//  Smack
//
//  Created by robot on 4/29/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketService.instance.establishConnection();
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SocketService.instance.closeConnection();
    }

}

