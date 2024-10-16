//
//  MediaDetailVM.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRAPILayer

final class MediaDetailVM: BaseViewModel {
    private var id: String
    var playerMediaType: MediaType

    @Published var media: MediaItemViewData?

    init(id: String, playerMediaType: MediaType) {
        self.id = id
        self.playerMediaType = playerMediaType
    }

    func loadData() {
        switch playerMediaType {
        case .artist:
            loadDataArtist()
        case .album:
            loadDataAlbum()
        default:
            return
        }
    }
}

// MARK: - Artist

extension MediaDetailVM {
    func getGenresOfArtist() -> [String] {
        if let artist = media?.player as? ArtistItemViewData {
            return artist.genres
        }
        return []
    }

    private func loadDataArtist() {
        apiGetArtist()
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

                let artistMapping = MediaFactory.mapping(type: .artist, data: response)
                self.media = MediaItemViewData(artistMapping)

                if self.media != nil {
                    self.apiGetArtistsTopTracks()
                    self.apiGetArtistAlbums()
                }
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
                let tracksMapping = tracks.map {
                    MediaFactory.mapping(type: .track, data: $0)
                }
                self.media?.tracks = tracksMapping.map { MediaItemViewData($0) }
                self.objectWillChange.send()
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
                let albumsMapping = items.map {
                    MediaFactory.mapping(type: .album, data: $0)
                }
                self.media?.albums = albumsMapping.map { MediaItemViewData($0) }
                self.objectWillChange.send()
            }.store(in: &cancellableSet)
    }
}

// MARK: - Album

extension MediaDetailVM {
    private func loadDataAlbum() {
        apiGetAlbum()
    }

    func getAlbumsArtists() -> String {
        if let album = media?.player as? AlbumItemViewData {
            return album.artists.map { $0.name }.joined(separator: ", ")
        }
        return ""
    }

    // TODO: - Get album
    private func apiGetAlbum() {
        let params = GetAlbumEndpoint.Request()
        GetAlbumEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let tracksModel = response.tracks.items else { return }

                let albumMapping = MediaFactory.mapping(type: .album, data: response)
                self.media = MediaItemViewData(albumMapping)

                let tracksMapping = tracksModel.map {
                    MediaFactory.mapping(type: .track, data: $0)
                }
                self.media?.tracks = tracksMapping.map { MediaItemViewData($0) }
                self.objectWillChange.send()
            }.store(in: &cancellableSet)
    }

    // TODO: - Get album's tracks
    private func apiGetAlbumsTracks() {
        let params = GetAlbumsTracksEndpoint.Request()
        GetAlbumsTracksEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.items else { return }
//                self.media?.tracks = items.map { TrackItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
