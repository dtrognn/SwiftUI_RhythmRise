//
//  GetSingleBrowseCategoryEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRCore

public struct GetSingleBrowseCategoryEndpoint: Endpoint {
    public static func service(_ id: String) -> GetSingleBrowseCategoryEndpoint {
        var service = GetSingleBrowseCategoryEndpoint()
        service.path = String(format: service.path, id)
        return service
    }

    public var path: String = "/v1/browse/categories/%@"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let locale: String

        public init(locale: LocaleRequest = .vn) {
            self.locale = locale.rawValue
        }
    }

    public struct Response: Codable {}
}
