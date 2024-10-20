//
//  AppState.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation
import RRAuthentication

struct AppState {
    var loginState: LoginState = .init()
}

class LoginState: ObservableObject {
    @Published var loggedIn: Bool = false

    init() {
        loggedIn = !UserContext.shared.userAccessToken.isEmpty
    }
}
