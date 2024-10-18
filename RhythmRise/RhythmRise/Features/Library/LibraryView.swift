//
//  LibraryView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm = LibraryVM()

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", hidesBottomBarWhenPushed: false, showNaviBar: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    savedList
                }.padding(.all, themeManager.layout.standardSpace)
                    .padding(.bottom, 3 * themeManager.layout.standardButtonHeight)
            }
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension LibraryView {
    var savedList: some View {
        return LazyVStack(spacing: themeManager.layout.standardSpace) {
            ForEach(vm.recents) { media in
                LibraryMediaItemView(media)
            }
        }
    }
}
