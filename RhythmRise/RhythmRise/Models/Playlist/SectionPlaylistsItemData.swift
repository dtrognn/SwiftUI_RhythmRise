//
//  SectionPlaylistsItemData.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import Foundation

class SectionPlaylistsItemData {
    var message: String
    var playlists: [MediaItemViewData]

    init(message: String, playlists: [MediaItemViewData]) {
        self.message = message
        self.playlists = playlists
    }
}
