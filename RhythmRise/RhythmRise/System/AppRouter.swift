//
//  AppRouter.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import RRCommon
import SwiftUI

class AppRouter: ObservableObject {
    enum AppFlow {
        case appLaunch
        case login
        case mainTab
    }

    @Published var screen: AppFlow = .appLaunch
    var onPopToRoot = PassthroughSubject<Void, Never>()

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        self.screen = .appLaunch
    }

    func subcribeLoginState() {
        AppDataManager.shared.appState.loginState.$loggedIn.sink { [weak self] isLoggedIn in
            self?.updateScreen(isLoggedIn)
        }.store(in: &cancellableSet)
    }

    func updateScreen(_ isLoggedIn: Bool) {
        if isLoggedIn {
            screen = .mainTab
        } else {
            screen = .login
        }
        onPopToRoot.send(())
    }

    func getInstanceScreen(_ screen: AppFlow) -> AnyView {
        switch screen {
        case .appLaunch:
            return SplashScreenView().asAnyView
        case .login:
            return LoginRouterView().asAnyView
        case .mainTab:
            return TabbarRouterView().asAnyView
        }
    }
}

struct AppRouterView: View {
    @StateObject private var router = Router()
    @StateObject private var appRouter = AppRouter()
    @StateObject private var languageManager = LanguageManager.shared
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var playerManager = PlayerManager.shared

    var body: some View {
        appRouter.getInstanceScreen(appRouter.screen)
            .onReceive(appRouter.onPopToRoot, perform: { _ in
                router.popToRoot()
            }).environmentObject(appRouter)
            .environmentObject(themeManager)
            .environmentObject(playerManager)
            .environmentObject(self.languageManager)
            .environment(\.locale, .init(identifier: self.languageManager.currentLanguage.getLanguageCode()))
    }
}
