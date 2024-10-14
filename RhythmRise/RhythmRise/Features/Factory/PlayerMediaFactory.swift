//
//  MappingPlayerFactory.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

final class PlayerMediaFactory {
    static func mapping(type: PlayerMediaType, data: Any) -> IPlayerMedia {
        var playerItemData: IPlayerMedia

        switch type {
        case .artist:
            playerItemData = ArtistItemViewData()
        default:
            // TODO: - Need refactor
            playerItemData = ArtistItemViewData()
        }
        playerItemData.mapData(data)

        return playerItemData
    }
}
