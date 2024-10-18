//
//  GetCategorysPlaylistsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRCore

public struct GetCategorysPlaylistsEndpoint: Endpoint {
    public static func service(_ id: String) -> GetCategorysPlaylistsEndpoint {
        var service = GetCategorysPlaylistsEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/browse/categories/%@/playlists"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let offset: Int

        public init(limit: Int = 2, offset: Int = 0) {
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {
        public let message: String
        public let playlists: PlaylistResponse
    }

    public struct PlaylistResponse: Codable {
        public let items: [PlaylistItemData]?
    }
}
