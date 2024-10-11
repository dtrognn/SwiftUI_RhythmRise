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
                .applyTheme(colorSelection)
        }.environment(\.locale, .init(identifier: self.languageIdentifier))
            .onReceive(LanguageManager.shared.onChangeLanguageBundle) { languageCode in
                self.languageIdentifier = languageCode.getLanguageCode()
            }
    }
}

struct TabbarRouterView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var activeTab: Tab = .home

    var body: some View {
        TabView(selection: self.$activeTab) {
            HomeRouterView()
                .tabItem {
                    TabItem(.home)
                }.tag(Tab.home)

            SearchView()
                .tabItem {
                    TabItem(.search)
                }.tag(Tab.search)

            LibraryView()
                .tabItem {
                    TabItem(.library)
                }.tag(Tab.library)
        }.tint(ThemeManager.shared.theme.iconColor)
    }
}
