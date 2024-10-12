//
//  GetNewReleasesEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetNewReleasesEndpoint: Endpoint {
    public static let service = GetNewReleasesEndpoint()

    public var path: String = "/v1/browse/new-releases"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let limit: Int
        public let offset: Int

        public init(limit: Int, offset: Int) {
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {
        public let albums: AlbumResponse
    }

    public struct AlbumResponse: Codable {
        public let items: [AlbumItemData]?
    }
}
