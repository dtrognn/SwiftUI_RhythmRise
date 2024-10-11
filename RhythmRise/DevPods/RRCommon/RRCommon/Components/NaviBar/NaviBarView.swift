//
//  NaviBarView.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

import SwiftUI

struct NaviBarView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @ObservedObject private var screenConfiguration: ScreenConfiguration

    init(_ screenConfiguration: ScreenConfiguration) {
        self.screenConfiguration = screenConfiguration
    }

    var body: some View {
        VStack(spacing: themeManager.layout.zero) {
            HStack {
                if screenConfiguration.showBackButton {
                    backButton
                }
                Spacer()
                Text(screenConfiguration.title)
                    .font(.headline)
                Spacer()
                backButton.opacity(0)
            }.padding(themeManager.layout.standardSpace)
                .navigationBarHidden(true)
                .background(
                    themeManager.theme.naviBackgroundColor
                        .ignoresSafeArea(edges: .top)
                )
            if screenConfiguration.showNaviUnderline {
                StraightLineView()
            }
        }
    }
}

private extension NaviBarView {
    private var backButton: some View {
        return Button {
            if screenConfiguration.onBackAction != nil {
                screenConfiguration.onBackAction?()
            } else {
                router.pop()
            }
        } label: {
            Image.image("ic_arrow_back")
                .resizable()
                .applyTheme(themeManager.theme.naviBackIconColor)
                .frame(width: 22, height: 22)
        }
    }

    var titleSection: some View {
        return VStack {
            Text(LocalizedStringKey(screenConfiguration.title))
                .font(themeManager.font.semibold16)
                .foregroundStyle(themeManager.theme.naviTextColor)
                .lineLimit(1)
        }
    }
}
