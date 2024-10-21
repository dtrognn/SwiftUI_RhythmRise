//
//  SearchView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm = SearchVM()

    var screenConfiguration: ScreenConfiguration {
        return .init(title: "", hidesBottomBarWhenPushed: false, showNaviBar: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        browseCategoriesView
                    }.padding(.bottom, themeManager.layout.standardButtonHeight)
                }
            }.padding(.all, themeManager.layout.standardSpace)
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension SearchView {
    var browseCategoriesView: some View {
        let columns: [GridItem] = [
            .init(.flexible()),
            .init(.flexible()),
        ]
        return LazyVGrid(columns: columns, spacing: themeManager.layout.standardSpace) {
            ForEach(vm.severalBrowseCategories) { media in
                BrowseCategoryItemView(media) { media in
                    router.route(to: SearchRoute.categorysPlaylists(media.id))
                }
            }
        }
    }
}
