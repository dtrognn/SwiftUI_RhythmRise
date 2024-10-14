//
//  PlayerItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

class PlayerItemViewData: Identifiable, ObservableObject {
    var id: String { player.id }
    var type: PlayerMediaType { player.type }
    var name: String { player.name }
    var imageUrl: String { player.imageUrl }
    var previewUrl: String { player.previewUrl }
    var description: String? { player.description }

    var tracks: [TrackItemViewData]?
    var albums: [AlbumItemViewData]?

    var player: IPlayerMedia

    init(_ player: IPlayerMedia) {
        self.player = player
    }
}
