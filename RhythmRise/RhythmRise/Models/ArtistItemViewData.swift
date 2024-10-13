//
//  ArtistItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRAPILayer

struct ArtistItemViewData: Identifiable {
    var id: String
    var name: String
    var images: [ImageData]
    var genres: [String]

    init(_ artist: ArtistItemModel) {
        self.id = artist.id
        self.name = artist.name
        self.images = artist.images?.map { ImageData($0) } ?? []
        self.genres = artist.genres?.map { $0 } ?? []
    }

    var imageLargeUrl: String {
        return images.max(by: { $0.width < $1.width })?.url ?? ""
    }
}
