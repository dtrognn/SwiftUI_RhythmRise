//
//  TrackItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class TrackItemViewData: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String = ""
    var album: AlbumItemViewData? = nil
    var artists: [ArtistItemViewData] = []
    var duration: Int = 0
    var previewUrl: String = ""

    init() {}

    init(_ track: TrackItemModel) {
        self.id = track.id
        self.name = track.name
        self.album = if let album = track.album { AlbumItemViewData(album) } else { nil }
        self.artists = track.artists.map { ArtistItemViewData($0) }
        self.duration = track.duration
        self.previewUrl = track.previewUrl ?? ""
    }
}

extension TrackItemViewData: IMediaItemData {
    var type: MediaType {
        return .track
    }

    var imageUrl: String {
        return album?.imageUrl ?? ""
    }

    func mapData(_ data: Any) {
        if let track = data as? TrackItemModel {
            update(
                id: track.id,
                name: track.name,
                album: track.album != nil ? AlbumItemViewData(track.album!) : nil,
                artists: track.artists.map { ArtistItemViewData($0) },
                duration: track.duration,
                previewUrl: track.previewUrl ?? "")
        }
    }

    private func update(id: String, name: String, album: AlbumItemViewData?, artists: [ArtistItemViewData], duration: Int, previewUrl: String) {
        self.id = id
        self.name = name
        self.album = album
        self.artists = artists
        self.duration = duration
        self.previewUrl = previewUrl
    }
}
