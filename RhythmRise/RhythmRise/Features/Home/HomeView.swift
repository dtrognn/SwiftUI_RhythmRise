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
    @EnvironmentObject private var playerManager: PlayerManager
    @StateObject private var vm = HomeVM()

    private let ITEM_COMMON_SIZE: CGFloat = 130
    private let ITEM_ARTIST_SIZE: CGFloat = 135

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
                        if !vm.popularPlaylists.isEmpty {
                            featuresPlaylistsView
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
        return HomeMediaSectionView(.init(
            title: language("Home_A_01"),
            medias: vm.favouriteArtists,
            itemSize: ITEM_ARTIST_SIZE,
            itemAlignment: .center,
            itemShape: .circle,
            itemImageContentMode: .fill,
            onSelect: { media in
                router.route(to: HomeRoute.artistDetail(media.id, media.type))
            }))
    }

    var recentlyPlayedTracksView: some View {
        return HomeMediaSectionView(.init(
            title: language("Home_A_02"),
            medias: vm.recentlyPlayedTracks,
            itemSize: ITEM_COMMON_SIZE,
            itemShape: .rect,
            onSelect: { media in
                presentPlayer(media)
            }))
    }

    var newReleasesView: some View {
        let displayName = AppDataManager.shared.userContext.displayName
        return HomeMediaSectionView(.init(
            title: language("Home_A_04"),
            medias: vm.newReleases,
            itemSize: ITEM_COMMON_SIZE,
            itemShape: .rect,
            onSelect: { media in
                router.route(to: HomeRoute.artistDetail(media.id, media.type))
            }))
    }

    var recommendationsView: some View {
        let displayName = AppDataManager.shared.userContext.displayName
        return HomeMediaSectionView(.init(
            title: String(format: language("Home_A_05"), displayName),
            medias: vm.recommendations,
            itemSize: ITEM_COMMON_SIZE,
            itemShape: .rect,
            onSelect: { media in
                presentPlayer(media)
            }))
    }

    func presentPlayer(_ media: MediaItemViewData) {
        playerManager.currentMedia = media
    }

    var featuresPlaylistsView: some View {
        return HomeMediaSectionView(.init(
            title: language("Home_A_06"),
            medias: vm.popularPlaylists,
            itemSize: ITEM_COMMON_SIZE,
            itemShape: .rect, onSelect: { _ in
                //
            }))
    }
}
