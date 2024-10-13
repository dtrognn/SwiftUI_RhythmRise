//
//  GetArtistsTopTracksEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetArtistsTopTracksEndpoint: Endpoint {
    public static func service(_ id: String) -> GetArtistsTopTracksEndpoint {
        var service = GetArtistsTopTracksEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/artists/%@/top-tracks"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let market: String

        public init(market: Market = .vn) {
            self.market = market.rawValue
        }
    }

    public struct Response: Codable {
        public let tracks: [TrackItemModel]?
    }
}
