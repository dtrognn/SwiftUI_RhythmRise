//
//  MediaItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import SwiftUI

class MediaItemViewData: Identifiable, ObservableObject {
    var id: String { player.id }
    var type: MediaType { player.type }
    var name: String { player.name }
    var imageUrl: String { player.imageUrl }
    var previewUrl: String { player.previewUrl }
    var description: String? { player.description }

    @Published var tracks: [MediaItemViewData]?
    @Published var albums: [MediaItemViewData]?
    @Published var color: Color = .red

    var player: IMediaItemData

    init(_ player: IMediaItemData) {
        self.player = player
//        fetchColor()
    }
}

extension MediaItemViewData {
    func getArtistsFormat() -> String {
        return getArtists().map { $0.name }.joined(separator: ", ")
    }

    private func fetchColor() {
        UtilsHelpers.fetchDominantColor(from: imageUrl) { [weak self] uiColor in
            guard let self = self else { return }

            guard let uiColor = uiColor else {
                self.color = .red
                return
            }
            self.color = Color(uiColor: uiColor)
        }
    }

    private func getArtists() -> [ArtistItemViewData] {
        switch type {
        case .track:
            if let track = player as? TrackItemViewData {
                return track.artists
            }
        case .album:
            if let album = player as? AlbumItemViewData {
                return album.artists
            }
        default:
            return []
        }

        return []
    }
}
