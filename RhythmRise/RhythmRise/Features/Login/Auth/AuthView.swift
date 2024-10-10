//
//  AuthView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct AuthView: View {
    @StateObject private var authVM = AuthVM()
    @StateObject private var webViewStore = WebViewVM()

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "Sign in", showBackButton: true, showNaviBar: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: .zero) {
                if webViewStore.showLoading {
                    ProgressView().applyTheme()
                }
                WebViewCommon(webViewStore)
            }.onAppear {
                webViewStore.loadData(AuthManager.shared.signInUrl?.absoluteString ?? "")
            }
        }.onReceive(webViewStore.onReceiveAuthorizationCode) { authorization in
            authVM.requestAccessToken(from: authorization)
        }
    }
}
