//
//  GetUsersSavedShowsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRCore

public struct GetUsersSavedShowsEndpoint: Endpoint {
    public static let service = GetUsersSavedShowsEndpoint()

    public var path: String = "/v1/me/shows"
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
        public let items: [ShowResponse]?
    }

    public struct ShowResponse: Codable {
        public let show: ShowItemData
        public let addedAt: String

        enum CodingKeys: String, CodingKey {
            case show
            case addedAt = "added_at"
        }
    }
}
