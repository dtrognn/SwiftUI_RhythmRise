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
//    public let album:
    public let artists: [ArtistItemModel]?
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case artists
    }
}
