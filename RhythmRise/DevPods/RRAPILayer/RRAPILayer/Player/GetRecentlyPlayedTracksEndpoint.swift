//
//  GetRecentlyPlayedTracksEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRCore

public struct GetRecentlyPlayedTracksEndpoint: Endpoint {
    public static let service = GetRecentlyPlayedTracksEndpoint()

    public var path: String = "/v1/me/player/recently-played"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let after: Int
        public let before: Int?

        public init(limit: Int, after: Int, before: Int? = nil) {
            self.limit = limit
            self.after = after
            self.before = before
        }
    }

    public struct Response: Codable {
        public let items: [RecentlyPlayedTracksModel]?
    }

    public struct RecentlyPlayedTracksModel: Codable {
        public let track: TrackItemModel
        public let playedAt: String

        enum CodingKeys: String, CodingKey {
            case track
            case playedAt = "played_at"
        }
    }
}
