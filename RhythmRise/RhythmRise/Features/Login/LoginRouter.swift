//
//  LoginRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

enum LoginRoute: Route {
    case auth
}

struct LoginRouterView: View {
    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            LoginView()
                .navigationDestination(for: LoginRoute.self) { destination in
                    switch destination {
                    case .auth:
                        AuthView()
                    }
                }
        }.environmentObject(router)
    }
}
