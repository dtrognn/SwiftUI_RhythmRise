//
//  GetFeaturedPlaylistEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 15/10/24.
//

import Foundation
import RRCore

public struct GetFeaturedPlaylistEndpoint: Endpoint {
    public static let service = GetFeaturedPlaylistEndpoint()

    public var path: String = "/v1/browse/featured-playlists"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let locale: String
        public let limit: Int
        public let offset: Int

        public init(locale: LocaleRequest = .vn, limit: Int = 10, offset: Int = 0) {
            self.locale = locale.rawValue
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {
        public let playlists: PlaylistsResponse
    }

    public struct PlaylistsResponse: Codable {
        public let items: [PlaylistItemData]?
    }
}
