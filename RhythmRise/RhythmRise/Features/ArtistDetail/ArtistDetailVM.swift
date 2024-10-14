//
//  ArtistDetailVM.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRAPILayer

final class ArtistDetailVM: BaseViewModel {
    private var id: String
    private var playerMediaType: PlayerMediaType

    @Published var player: PlayerItemViewData?
    @Published var topTracks: [TrackItemViewData] = []
    @Published var albums: [AlbumItemViewData] = []

    init(id: String, playerMediaType: PlayerMediaType) {
        self.id = id
        self.playerMediaType = playerMediaType
    }

    func loadData() {
        switch playerMediaType {
        case .artist:
            loadDataArtist()
        default:
            return
        }
    }
}

// MARK: - Artist

extension ArtistDetailVM {
    func getGenresOfArtist() -> [String] {
        if let artist = player?.player as? ArtistItemViewData {
            return artist.genres
        }
        return []
    }

    private func loadDataArtist() {
        apiGetArtist()
        apiGetArtistsTopTracks()
        apiGetArtistAlbums()
    }

    // TODO: - Get artist
    private func apiGetArtist() {
        let params = GetArtistEndpoint.Request()
        GetArtistEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let artistMapping = PlayerMediaFactory.mapping(type: .artist, data: response)
                self.player = PlayerItemViewData(artistMapping)
            }.store(in: &cancellableSet)
    }

    // TODO: - Get artist's top tracks
    private func apiGetArtistsTopTracks() {
        let params = GetArtistsTopTracksEndpoint.Request()
        GetArtistsTopTracksEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                guard let tracks = response.tracks else { return }
                self.topTracks = tracks.map { TrackItemViewData($0) }
                self.player?.tracks = tracks.map { TrackItemViewData($0) }
            }.store(in: &cancellableSet)
    }

    // TODO: - Get artist's albums
    private func apiGetArtistAlbums() {
        let params = GetArtistsAlbumsEndpoint.Request()
        GetArtistsAlbumsEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                guard let items = response.items else { return }
                self.albums = items.map { AlbumItemViewData($0) }
                self.player?.albums = items.map { AlbumItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
