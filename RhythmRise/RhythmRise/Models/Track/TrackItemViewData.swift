//
//  TrackItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class TrackItemViewData: Identifiable, Hashable {
    private var track: TrackItemModel

    static func == (lhs: TrackItemViewData, rhs: TrackItemViewData) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(_ track: TrackItemModel) {
        self.track = track
    }

    var id: String {
        return track.id
    }

    var name: String {
        return track.name
    }

    var album: AlbumItemViewData {
        return AlbumItemViewData(track.album)
    }

    var artists: [ArtistItemViewData] {
        return track.artists.map { ArtistItemViewData($0) }
    }

    var duration: Int {
        return track.duration
    }

    var previewUrl: String {
        return track.previewUrl ?? ""
    }
}
