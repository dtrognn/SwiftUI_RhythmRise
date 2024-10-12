//
//  GetUsersTopItemsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRCore

public struct GetUsersTopItemsEndpoint: Endpoint {
    public static func service(type: TopType) -> GetUsersTopItemsEndpoint {
        var service = GetUsersTopItemsEndpoint()
        service.path = String(format: service.path, type.rawValue)
        return service
    }

    public enum TopType: String {
        case artists
        case tracks
    }

    public enum TimeRange: String {
        case long = "long_term"
        case medium = "medium_term"
        case short = "short_term"
    }

//    public var path: String = "/v1/me/top/%@"
    public var path: String = "/v1/me/top/%@"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let timeRange: String
        public let limit: Int
        public let offset: Int

        public init(timeRange: TimeRange = .medium, limit: Int = 10, offset: Int = 0) {
            self.timeRange = timeRange.rawValue
            self.limit = limit
            self.offset = offset
        }

        enum CodingKeys: String, CodingKey {
            case timeRange = "time_range"
            case limit
            case offset
        }
    }

    public struct Response: Codable {
        public let items: [ArtistItemModel]?
    }
}
