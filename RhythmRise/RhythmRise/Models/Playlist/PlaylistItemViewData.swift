//
//  PlaylistItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 15/10/24.
//

import Foundation
import RRAPILayer

class PlaylistItemViewData: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String = ""
    var description: String = ""
    var images: [ImageData] = []

    init() {}

    init(_ playlist: PlaylistItemData) {
        self.id = playlist.id
        self.name = playlist.name
        self.description = playlist.description
        self.images = playlist.images?.map { ImageData($0) } ?? []
    }
}

extension PlaylistItemViewData: IMediaItemData {
    var type: MediaType {
        return .playlist
    }

    var imageUrl: String {
        return self.images.first?.url ?? ""
    }

    var previewUrl: String {
        return ""
    }

    func mapData(_ data: Any) {
        if let playlist = data as? PlaylistItemData {
            self.id = playlist.id
            self.name = playlist.name
            self.description = playlist.description
            self.images = playlist.images?.map { ImageData($0) } ?? []
        }
    }
}
