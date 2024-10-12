//
//  AlbumItemData.swift
//  RRCommon
//
//  Created by dtrognn on 12/10/24.
//

import Foundation

public struct AlbumItemData: Codable {
    public let id: String
    public let name: String
    public let totalTracks: Int
    public let albumType: String
    public let artists: [ArtistItemModel]
    public let images: [ImageItemModel]?
    public let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case totalTracks = "total_tracks"
        case albumType = "album_type"
        case artists
        case images
        case releaseDate = "release_date"
    }
}
