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
    @Published var favouriteArtists: [ArtistItemViewData] = []
    @Published var recentlyPlayedTracks: [TrackItemViewData] = []
    @Published var newReleases: [AlbumItemViewData] = []

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

                guard let artists = response.items else {
                    return
                }
                self.favouriteArtists = artists.map { ArtistItemViewData($0) }
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
                self.recentlyPlayedTracks = recentlyPlayedTracks.map { TrackItemViewData($0.track) }
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
                self.newReleases = items.map { AlbumItemViewData($0) }
            }.store(in: &cancellableSet)

    }
}
