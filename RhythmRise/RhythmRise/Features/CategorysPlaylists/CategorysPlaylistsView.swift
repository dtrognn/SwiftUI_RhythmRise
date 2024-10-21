//
//  CategorysPlaylistsView.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import RRCommon
import SwiftUI

struct CategorysPlaylistsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm: CategorysPlaylistsVM

    private let ITEM_SIZE: CGFloat = 130

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", showBackButton: true, showNaviUnderline: false, showNaviBar: true)
    }

    init(_ categoryId: String) {
        self._vm = StateObject(wrappedValue: CategorysPlaylistsVM(categoryId))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    categorySectionView
                }
            }
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension CategorysPlaylistsView {
    var categorySectionView: some View {
        return HomeMediaSectionView(.init(
            title: vm.sectionPlaylists?.message ?? "",
            medias: vm.sectionPlaylists?.playlists ?? [],
            itemSize: ITEM_SIZE,
            itemShape: .rect))
    }
}
