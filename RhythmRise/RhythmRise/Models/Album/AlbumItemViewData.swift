//
//  AlbumItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class AlbumItemViewData: Identifiable {
    private var album: AlbumItemData

    init(_ album: AlbumItemData) {
        self.album = album
    }

    var id: String {
        return album.id
    }

    var name: String {
        return album.name
    }

    var artists: [ArtistItemViewData] {
        return album.artists.map { ArtistItemViewData($0) }
    }

    var images: [ImageData] {
        return album.images?.map { ImageData($0) } ?? []
    }

    var imageUrl: String {
        return images.max(by: { $0.width < $1.width })?.url ?? ""
    }
}
