//
//  GetUsersSavedAlbumsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRCore

public struct GetUsersSavedAlbumsEndpoint: Endpoint {
    public static let service = GetUsersSavedAlbumsEndpoint()

    public var path: String = "/v1/me/albums"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let offset: Int
        public let market: String

        public init(limit: Int = 2, offset: Int = 0, market: Market = .vn) {
            self.limit = limit
            self.offset = offset
            self.market = market.rawValue
        }
    }

    public struct Response: Codable {
        public let items: [AlbumResponse]?
    }

    public struct AlbumResponse: Codable {
        public let album: AlbumItemData
        public let addedAt: String

        enum CodingKeys: String, CodingKey {
            case album
            case addedAt = "added_at"
        }
    }
}
