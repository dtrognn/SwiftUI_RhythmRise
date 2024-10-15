//
//  MediaItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

class MediaItemViewData: Identifiable, ObservableObject {
    var id: String { player.id }
    var type: MediaType { player.type }
    var name: String { player.name }
    var imageUrl: String { player.imageUrl }
    var previewUrl: String { player.previewUrl }
    var description: String? { player.description }

    @Published var tracks: [TrackItemViewData]?
    @Published var albums: [AlbumItemViewData]?

    var player: IMediaItemData

    init(_ player: IMediaItemData) {
        self.player = player
    }
}
