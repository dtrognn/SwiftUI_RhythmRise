//
//  ScreenContainerView.swift
//  Pods
//
//  Created by dtrognn on 10/10/24.
//


import SwiftUI

public struct ScreenContainerView<Content: View>: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @ObservedObject public var screenConfiguration: ScreenConfiguration
    public var content: Content

    public init(_ screenConfiguration: ScreenConfiguration, @ViewBuilder content: () -> Content) {
        self.screenConfiguration = screenConfiguration
        self.content = content()
    }

    public var body: some View {
        bodyView
    }

    var bodyView: some View {
        ZStack(alignment: .top) {
            themeManager.theme.backgroundColor
                .ignoresSafeArea()

            VStack(spacing: .zero) {
                if screenConfiguration.showNaviBar {
                    NaviBarView(screenConfiguration)
                }
                content
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                    .navigationBarHidden(true)
                    .toolbar(screenConfiguration.hidesBottomBarWhenPushed ? .hidden : .visible, for: .tabBar)
                    .onDisappear {
                        if screenConfiguration.hidesBottomBarWhenPushed == true {
                            screenConfiguration.hidesBottomBarWhenPushed = false
                        }
                    }
            }
        }.ignoresSafeArea(edges: .bottom)
    }
}
