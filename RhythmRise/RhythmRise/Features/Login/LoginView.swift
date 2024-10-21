//
//  LoginView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", showNaviBar: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(alignment: .leading, spacing: .zero) {
                Spacer()
                loginButton
                    .padding(.horizontal, themeManager.layout.standardSpace)
                    .padding(.bottom, themeManager.layout.standardButtonHeight)
            }
        }
    }
}

private extension LoginView {
    var loginButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.route(to: LoginRoute.auth)
        } label: {
            Text("Sign in with Spotify")
                .font(themeManager.font.medium16)
                .foregroundStyle(themeManager.theme.btTextEnableColor)
                .frame(maxWidth: .infinity)
                .frame(height: themeManager.layout.standardButtonHeight)
                .background(themeManager.theme.btBackgroundEnableColor)
                .cornerRadius(themeManager.layout.standardButtonHeight / 2)
        }
    }
}
