//
//  TrackItemModel.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

public struct TrackItemModel: Codable {
    public let id: String
    public let name: String
    public let album: AlbumItemData
    public let artists: [ArtistItemModel]
    public let type: String
    public let duration: Int
    public let previewUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case album
        case type
        case artists
        case duration = "duration_ms"
        case previewUrl = "preview_url"
    }
}
