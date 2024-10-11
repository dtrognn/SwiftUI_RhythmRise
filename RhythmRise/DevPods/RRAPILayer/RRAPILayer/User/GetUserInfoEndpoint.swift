//
//  GetUserInfoEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRCore

public struct GetCurrentUserInfoEndpoint: Endpoint {
    public static let service = GetCurrentUserInfoEndpoint()

    public var path: String = "/v1/me"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public init() {}
    }

    public struct Response: Codable {
        public let id: String
        public let explicitContent: ExplicitContent
        public let product: String
        public let displayName: String
        public let images: [Image]?
        public let email: String

        public enum CodingKeys: String, CodingKey {
            case id
            case explicitContent = "explicit_content"
            case product
            case displayName = "display_name"
            case images
            case email
        }
    }

    public struct ExplicitContent: Codable {
        public let filterLocked: Bool
        public let filterEnabled: Bool

        public enum CodingKeys: String, CodingKey {
            case filterLocked = "filter_locked"
            case filterEnabled = "filter_enabled"
        }

        public init(filterLocked: Bool, filterEnabled: Bool) {
            self.filterLocked = filterLocked
            self.filterEnabled = filterEnabled
        }
    }

    public struct Image: Codable {
        public let url: String
        public let width: Int
        public let height: Int

        public enum CodingKeys: String, CodingKey {
            case url
            case width
            case height
        }

        public init(url: String, width: Int, height: Int) {
            self.url = url
            self.width = width
            self.height = height
        }
    }
}
