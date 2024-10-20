//
//  ArtistItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRAPILayer

class ArtistItemViewData: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String = ""
    var images: [ImageData] = []
    var genres: [String] = []
    var numberOfFollowers: Int = 0

    init() {}

    init(_ artist: ArtistItemModel) {
        self.id = artist.id
        self.name = artist.name
        self.images = artist.images?.map { ImageData($0) } ?? []
        self.genres = artist.genres?.map { $0 } ?? []
        self.numberOfFollowers = artist.followers?.total ?? 0
    }

    var imageLargeUrl: String {
        return images.first?.url ?? ""
    }
}

extension ArtistItemViewData: IMediaItemData {
    var imageUrl: String {
        return imageLargeUrl
    }

    var description: String? {
        return String(format: "%d %@", numberOfFollowers, language("Media_Detail_A_01"))
    }

    var previewUrl: String {
        return ""
    }

    var type: MediaType {
        return .artist
    }

    func mapData(_ data: Any) {
        if let artist = data as? GetArtistEndpoint.Response {
            update(id: artist.id,
                   name: artist.name,
                   images: artist.images?.map { ImageData($0) } ?? [],
                   genres: artist.genres?.map { $0 } ?? [],
                   numberOfFollowers: artist.followers?.total ?? 0)
        } else if let artist = data as? ArtistItemModel {
            update(id: artist.id,
                   name: artist.name,
                   images: artist.images?.map { ImageData($0) } ?? [],
                   genres: artist.genres?.map { $0 } ?? [],
                   numberOfFollowers: artist.followers?.total ?? 0)
        }
    }

    private func update(id: String, name: String, images: [ImageData], genres: [String], numberOfFollowers: Int) {
        self.id = id
        self.name = name
        self.images = images
        self.genres = genres
        self.numberOfFollowers = numberOfFollowers
    }
}
