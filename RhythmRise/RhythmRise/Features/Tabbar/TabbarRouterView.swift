//
//  TabbarRouterView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct TabItem: View {
    private var tab: Tab
    @State var languageIdentifier = LanguageManager.shared.currentLanguage.getLanguageCode()

    let colorSelection = ThemeManager.shared.theme.iconColor

    init(_ tab: Tab) {
        self.tab = tab
    }

    var body: some View {
        Label {
            Text(language(self.tab.title))
                .foregroundStyle(self.colorSelection)
        } icon: {
            Image(self.tab.image)
                .applyTheme(self.colorSelection)
        }.environment(\.locale, .init(identifier: self.languageIdentifier))
            .onReceive(LanguageManager.shared.onChangeLanguageBundle) { languageCode in
                self.languageIdentifier = languageCode.getLanguageCode()
            }
    }
}

struct TabbarRouterView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var playerManager: PlayerManager
    @State private var activeTab: Tab = .home
    @State private var presentPlayerView: Bool = false

    var body: some View {
        ZStack {
            self.tabView

            VStack(spacing: self.themeManager.layout.zero) {
                Spacer()

                if self.playerManager.isShowMiniPlayer {
                    MiniPlayerView {
                        self.presentPlayerView = true
                    }
                }
            }.padding(.bottom, UITabBarController().height + self.themeManager.layout.smallSpace)
                .transition(.move(edge: .bottom))
                .animation(.default, value: self.playerManager.isShowMiniPlayer)
        }.fullScreenCover(isPresented: self.$presentPlayerView, content: {
            PlayerView(self.$presentPlayerView)
        })
    }

    var tabView: some View {
        return TabView(selection: self.$activeTab) {
            HomeRouterView()
                .tabItem {
                    TabItem(.home)
                }.tag(Tab.home)

            SearchRouterView()
                .tabItem {
                    TabItem(.search)
                }.tag(Tab.search)

            LibraryRouter()
                .tabItem {
                    TabItem(.library)
                }.tag(Tab.library)
        }.tint(ThemeManager.shared.theme.iconColor)
    }
}
