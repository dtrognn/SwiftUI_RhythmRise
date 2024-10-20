//
//  HomeVM.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRAPILayer
import RRCommon

final class HomeVM: BaseViewModel {
    @Published var userAvatarUrl: String = ""
    @Published var favouriteArtists: [MediaItemViewData] = []
    @Published var recentlyPlayedTracks: [MediaItemViewData] = []
    @Published var newReleases: [MediaItemViewData] = []
    @Published var recommendations: [MediaItemViewData] = []
    @Published var popularPlaylists: [MediaItemViewData] = []

    private var isLoadFirst: Bool = true

    func loadData() {
        if isLoadFirst {
            isLoadFirst = false
            loadDataAPI()
        }
    }

    private func loadDataAPI() {
        apiGetCurrentUserInfo()
        apiGetTopArtists()
        apiGetFeaturedPlaylists()
        apiGetRecentlyPlayedTracks()
        apiGetNewReleases()
    }
}

// MARK: - API

extension HomeVM {
    // MARK: - Get current user info

    private func apiGetCurrentUserInfo() {
        let params = GetCurrentUserInfoEndpoint.Request()
        GetCurrentUserInfoEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let avatar = response.images?.first else { return }
                self.userAvatarUrl = avatar.url

                AppDataManager.shared.userContext.saveUserInfo(
                    id: response.id,
                    email: response.email,
                    displayName: response.displayName,
                    imageUrl: avatar.url)
            }.store(in: &cancellableSet)
    }

    // MARK: - Get top favourite artists

    private func apiGetTopArtists() {
        let params = GetUsersTopItemsEndpoint.Request()
        GetUsersTopItemsEndpoint.service(type: .artists).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                guard let artists = response.items else { return }

                let artistsMapping = artists.map {
                    MediaFactory.mapping(type: .artist, data: $0)
                }

                self.favouriteArtists = artistsMapping.map {
                    MediaItemViewData($0)
                }

                if self.favouriteArtists.count >= 5 {
                    self.apiGetRecommendations()
                }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get recently played tracks

    private func apiGetRecentlyPlayedTracks() {
        let numberOfSecondInAMonth = 2_592_000
        let timeAfter = Date().timeIntervalSince1970() - numberOfSecondInAMonth

        let params = GetRecentlyPlayedTracksEndpoint.Request(limit: 10, after: timeAfter)
        GetRecentlyPlayedTracksEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let recentlyPlayedTracks = response.items else { return }
                let tracksMapping = recentlyPlayedTracks.map {
                    MediaFactory.mapping(type: .track, data: $0.track)
                }
                self.recentlyPlayedTracks = tracksMapping.map {
                    MediaItemViewData($0)
                }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get new release

    private func apiGetNewReleases() {
        let params = GetNewReleasesEndpoint.Request(limit: 10, offset: 0)
        GetNewReleasesEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.albums.items else { return }
                let albumsMapping = items.map {
                    MediaFactory.mapping(type: .album, data: $0)
                }
                self.newReleases = albumsMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get current user's playlists

    // test api mới thấy trả về 1 item
    private func apiGetCurrentUsersPlaylists() {
        let params = GetCurrentUsersPlaylistsEndpoint.Request()
        GetCurrentUsersPlaylistsEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get recommendations

    private func apiGetRecommendations() {
        let seedArtists = favouriteArtists.prefix(5).map { $0.id }.joined(separator: ",")
        let params = GetRecommendationsEndpoint.Request(seedArtists: seedArtists)
        GetRecommendationsEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let tracks = response.tracks else { return }
                let tracksMapping = tracks.map {
                    MediaFactory.mapping(type: .track, data: $0)
                }
                self.recommendations = tracksMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get featured playlists

    private func apiGetFeaturedPlaylists() {
        let params = GetFeaturedPlaylistEndpoint.Request()
        GetFeaturedPlaylistEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.playlists.items else { return }
                let playlistsMapping = items.map {
                    MediaFactory.mapping(type: .playlist, data: $0)
                }
                self.popularPlaylists = playlistsMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
