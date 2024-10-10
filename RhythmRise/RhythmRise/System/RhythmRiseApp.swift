//
//  RhythmRiseApp.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

@main
struct RhythmRiseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AppRouterView()
        }
    }
}
