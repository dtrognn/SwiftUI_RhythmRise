//
//  GetCurrentUsersPlaylistsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetCurrentUsersPlaylistsEndpoint: Endpoint {
    public static let service = GetCurrentUsersPlaylistsEndpoint()

    public var path: String = "/v1/me/playlists"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let offset: Int

        public init(limit: Int = 5, offset: Int = 0) {
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {}
}
