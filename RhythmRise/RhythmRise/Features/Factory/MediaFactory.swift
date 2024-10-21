//
//  MappingPlayerFactory.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

final class MediaFactory {
    static func mapping(type: MediaType, data: Any) -> IMediaItemData {
        var playerItemData: IMediaItemData

        switch type {
        case .artist:
            playerItemData = ArtistItemViewData()
        case .album:
            playerItemData = AlbumItemViewData()
        case .playlist:
            playerItemData = PlaylistItemViewData()
        case .track:
            playerItemData = TrackItemViewData()
        case .browseCatgory:
            playerItemData = BrowseCategoryItemViewData()
        case .show:
            playerItemData = ShowItemViewData()
        case .episode:
            playerItemData = EpisodeItemViewData()
        default:
            // TODO: - Need refactor
            playerItemData = ArtistItemViewData()
        }
        playerItemData.mapData(data)

        return playerItemData
    }
}
