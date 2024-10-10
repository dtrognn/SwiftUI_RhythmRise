//
//  AppDataManager.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

final class AppDataManager {
    static let shared = AppDataManager()

    let appState: AppState
    let appLanguage: AppLanguage

    init() {
        appState = AppState()
        appLanguage = AppLanguage()
    }

    var isLogout: Bool {
        return !appState.loginState.loggedIn
    }

    func updateLoginState(_ loggedIn: Bool) {
        appState.loginState.loggedIn = loggedIn
    }
}
