//
//  ArtistDetailVM.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRAPILayer

final class ArtistDetailVM: BaseViewModel {
    private var artistId: String

    @Published var artist: ArtistItemViewData?
    @Published var topTracks: [TrackItemViewData] = []
    @Published var albums: [AlbumItemViewData] = []

    init(_ artistId: String) {
        self.artistId = artistId
    }

    func loadData() {
        apiGetArtist()
        apiGetArtistsTopTracks()
        apiGetArtistAlbums()
    }
}

// MARK: - API

extension ArtistDetailVM {
    // MARK: - Get artist

    private func apiGetArtist() {
        let params = GetArtistEndpoint.Request()
        GetArtistEndpoint.service(artistId).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.artist = ArtistItemViewData(response)
            }.store(in: &cancellableSet)
    }

    // MARK: - Get artist's top tracks

    private func apiGetArtistsTopTracks() {
        let params = GetArtistsTopTracksEndpoint.Request()
        GetArtistsTopTracksEndpoint.service(artistId).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                guard let tracks = response.tracks else { return }
                self.topTracks = tracks.map { TrackItemViewData($0) }
            }.store(in: &cancellableSet)
    }

    // MARK: - Get artist's albums

    private func apiGetArtistAlbums() {
        let params = GetArtistsAlbumsEndpoint.Request()
        GetArtistsAlbumsEndpoint.service(artistId).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                guard let items = response.items else { return }
                self.albums = items.map { AlbumItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}

private extension ArtistItemViewData {
    init(_ data: GetArtistEndpoint.Response) {
        self.id = data.id
        self.name = data.name
        self.images = data.images?.map { ImageData($0) } ?? []
        self.genres = data.genres?.map { $0 } ?? []
    }
}
