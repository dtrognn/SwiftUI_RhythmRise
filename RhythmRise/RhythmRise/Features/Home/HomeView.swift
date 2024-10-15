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

    @State private var presentPlayerView: Bool = false

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
        }.fullScreenCover(isPresented: $presentPlayerView, content: {
            PlayerView($presentPlayerView)
        }).onAppear {
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
                router.route(to: HomeRoute.artistDetail(media.id, .artist))
            }))
    }

    var recentlyPlayedTracksView: some View {
        return RecentlyPlayedTrackView(vm.recentlyPlayedTracks) { track in
            presentPlayer(track)
        }
    }

    var newReleasesView: some View {
        return NewReleasesView(vm.newReleases) { album in
            router.route(to: HomeRoute.artistDetail(album.id, .album))
        }
    }

    var recommendationsView: some View {
        return RecommendationsView(vm.recommendations) { track in
            presentPlayer(track)
        }
    }

    func presentPlayer(_ track: TrackItemViewData) {
        playerManager.currentTrack = track
        presentPlayerView = true
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
