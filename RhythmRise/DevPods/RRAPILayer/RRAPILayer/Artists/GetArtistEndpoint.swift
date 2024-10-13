//
//  GetArtistEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 13/10/24.
//

import Foundation
import RRCore

public struct GetArtistEndpoint: Endpoint {
    public static func service(_ id: String) -> GetArtistEndpoint {
        var service = GetArtistEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/artists/%@"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public init() {}
    }

    public struct Response: Codable {
        public let id: String
        public let genres: [String]?
        public let images: [ImageItemModel]?
        public let followers: FollowersModel?
        public let popularity: Int?
        public let type: String?
        public let name: String
    }
}
