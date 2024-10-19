//
//  GetShowEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 19/10/24.
//

import Foundation
import RRCore

public struct GetShowEndpoint: Endpoint {
    public static func service(_ id: String) -> GetShowEndpoint {
        var service = GetShowEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/shows/%@"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let market: String

        public init(market: Market = .vn) {
            self.market = market.rawValue
        }
    }

    public struct Response: Codable {
        public let id: String
        public let name: String
        public let publisher: String
        public let description: String
        public let images: [ImageItemModel]?
        public let episodes: EpisodeResponse
        public let uri: String
    }

    public struct EpisodeResponse: Codable {
        public let items: [EpisodeItemData]?
    }
}
