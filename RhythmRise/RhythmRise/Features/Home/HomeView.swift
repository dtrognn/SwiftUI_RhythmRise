//
//  HomeView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm = HomeVM()

    var screenConfiguration: ScreenConfiguration {
        return .init(title: "", hidesBottomBarWhenPushed: false, showNaviBar: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack {
                headerView
            }
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension HomeView {
    var headerView: some View {
        return HStack(spacing: themeManager.layout.mediumSpace) {
            userImageButton
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, themeManager.layout.standardSpace)
            .padding(.vertical, themeManager.layout.mediumSpace)
    }

    var userImageButton: some View {
        return Button {
            // TODO: -
        } label: {
            ImageUrl(configuration: .init(urlString: vm.userAvatarUrl)) {
                ProgressView().applyTheme()
            }.frame(width: 32, height: 32)
                .clipShape(.circle)
        }
    }
}
