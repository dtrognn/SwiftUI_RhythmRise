//
//  AlbumItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class AlbumItemViewData: Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var artists: [ArtistItemViewData] = []
    var images: [ImageData] = []
    var releaseDate: String = ""

    init() {}

    init(_ album: AlbumItemData) {
        self.id = album.id
        self.name = album.name
        self.artists = album.artists.map { ArtistItemViewData($0) }
        self.images = album.images?.map { ImageData($0) } ?? []
        self.releaseDate = album.releaseDate
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }
}

extension AlbumItemViewData: IMediaItemData {
    var type: MediaType {
        return .album
    }

    var description: String? {
        return String(format: "%@: %@", language("Media_Detail_A_04"), releaseDate)
    }

    var previewUrl: String {
        return ""
    }

    func mapData(_ data: Any) {
        if let album = data as? GetAlbumEndpoint.Response {
            update(id: album.id,
                   name: album.name,
                   artists: album.artists.map { ArtistItemViewData($0) },
                   images: album.images?.map { ImageData($0) } ?? [],
                   releaseDate: album.releaseDate)
        } else if let album = data as? AlbumItemData {
            update(id: album.id,
                   name: album.name,
                   artists: album.artists.map { ArtistItemViewData($0) },
                   images: album.images?.map { ImageData($0) } ?? [],
                   releaseDate: album.releaseDate)
        }
    }

    private func update(id: String, name: String, artists: [ArtistItemViewData], images: [ImageData], releaseDate: String) {
        self.id = id
        self.name = name
        self.artists = artists
        self.images = images
        self.releaseDate = releaseDate
    }
}
