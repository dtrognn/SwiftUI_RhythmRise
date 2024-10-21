//
//  GetArtistsAlbums.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetArtistsAlbumsEndpoint: Endpoint {
    public static func service(_ id: String) -> GetArtistsAlbumsEndpoint {
        var service = GetArtistsAlbumsEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/artists/%@/albums"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let includeGroups: String
        public let market: String
        public let limit: Int
        public let offset: Int

        public init(includeGroups: String = IncludeGroups.allCases.map { $0.rawValue }.joined(separator: ","),
                    market: Market = .vn,
                    limit: Int = 5,
                    offset: Int = 0)
        {
            self.includeGroups = includeGroups
            self.market = market.rawValue
            self.limit = limit
            self.offset = offset
        }

        enum CodingKeys: String, CodingKey {
            case includeGroups = "include_groups"
            case market
            case limit
            case offset
        }
    }

    public struct Response: Codable {
        public let items: [AlbumItemData]?
    }
}
