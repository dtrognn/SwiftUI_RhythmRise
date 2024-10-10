//
//  AppDelegate.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        AppConfigurationManager.shared.loadCommonConfig()

        return true
    }
}
