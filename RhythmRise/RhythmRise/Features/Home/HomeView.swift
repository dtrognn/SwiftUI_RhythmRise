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
            VStack(spacing: themeManager.layout.zero) {
                headerView
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: themeManager.layout.largeSpace) {
                        if !vm.favouriteArtists.isEmpty {
                            favouriteArtistsView
                        }
                        if !vm.recentlyPlayedTracks.isEmpty {
                            recentlyPlayedTracksView
                        }
                        if !vm.recommendations.isEmpty {
                            recommendationsView
                        }
                        if !vm.newReleases.isEmpty {
                            newReleasesView
                        }
                    }.padding(.bottom, themeManager.layout.standardButtonHeight * 4)
                }
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

private extension HomeView {
    var favouriteArtistsView: some View {
        return FavouriteArtistsView(vm.favouriteArtists) { artist in
            router.route(to: HomeRoute.artistDetail(artist.id))
        }
    }

    var recentlyPlayedTracksView: some View {
        return RecentlyPlayedTrackView(vm.recentlyPlayedTracks) { _ in
            // TODO: -
        }
    }

    var newReleasesView: some View {
        return NewReleasesView(vm.newReleases) { _ in
            // TODO: -
        }
    }

    var recommendationsView: some View {
        return RecommendationsView(vm.recommendations) { _ in
            // TODO: -
        }
    }
}
