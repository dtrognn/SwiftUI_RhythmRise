//
//  GetAlbumEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 14/10/24.
//

import Foundation
import RRCore

public struct GetAlbumEndpoint: Endpoint {
    public static func service(_ id: String) -> GetAlbumEndpoint {
        var service = GetAlbumEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/albums/%@"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let market: String

        public init(market: Market = .vn) {
            self.market = market.rawValue
        }
    }

    public struct Response: Codable {
        public let id: String
        public let name: String
        public let totalTracks: Int
        public let albumType: String
        public let artists: [ArtistItemModel]
        public let images: [ImageItemModel]?
        public let releaseDate: String
        public let tracks: TracksResponse

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case totalTracks = "total_tracks"
            case albumType = "album_type"
            case artists
            case images
            case releaseDate = "release_date"
            case tracks
        }
    }

    public struct TracksResponse: Codable {
        public let items: [TrackItemModel]?
    }
}
