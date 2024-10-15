//
//  GetAlbumsTracksEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 14/10/24.
//

import Foundation
import RRCore

public struct GetAlbumsTracksEndpoint: Endpoint {
    public static func service(_ id: String) -> GetAlbumsTracksEndpoint {
        var service = GetAlbumsTracksEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/albums/%@/tracks"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let market: String
        public let limit: Int
        public let offset: Int

        public init(market: Market = .vn, limit: Int = 10, offset: Int = 0) {
            self.market = market.rawValue
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {
        public let items: [TrackItemModel]?
    }
}
