//
//  AppDelegate.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import Reachability
import JQProgressHUD

struct MyMediaFinderConf {
    static var connectionActive = true
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ReachabilityObserverDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try? addReachabilityObserver()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            JQProgressHUDTool.jq_showToastHUD(msg: "No hay conexión a internet!")
        }
        
        MyMediaFinderConf.connectionActive = isReachable
    }
}

