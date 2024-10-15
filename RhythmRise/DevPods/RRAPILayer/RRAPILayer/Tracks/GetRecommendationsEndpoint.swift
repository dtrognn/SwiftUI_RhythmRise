//
//  GetRecommendationsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetRecommendationsEndpoint: Endpoint {
    public static let service = GetRecommendationsEndpoint()

    public var path: String = "/v1/recommendations"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let market: String
        public let seedArtists: String

        public init(limit: Int = 10, market: Market = .vn, seedArtists: String) {
            self.limit = limit
            self.market = market.rawValue
            self.seedArtists = seedArtists
        }

        enum CodingKeys: String, CodingKey {
            case limit
            case market
            case seedArtists = "seed_artists"
        }
    }

    public struct Response: Codable {
        public let tracks: [TrackItemModel]?
    }
}
