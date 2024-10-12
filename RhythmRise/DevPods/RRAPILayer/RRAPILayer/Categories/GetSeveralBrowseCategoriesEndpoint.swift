//
//  GetSeveralBrowseCategoriesEndpoint.swift
//  RRCommon
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRCore

public struct GetSeveralBrowseCategoriesEndpoint: Endpoint {
    public static let service = GetSeveralBrowseCategoriesEndpoint()

    public var path: String = "/v1/browse/categories"
    public var method: HTTPMethod = .GET
    public var headers: [String : String]? = nil

    public struct Request: Codable {
        public let locale: String
        public let limit: Int
        public let offset: Int

        public init(locale: String = "vi_VN", limit: Int, offset: Int = 0) {
            self.locale = locale
            self.limit = limit
            self.offset = offset
        }
    }

    public struct Response: Codable {
        public let categories: BrowseCategoryItemModel
    }

    public struct BrowseCategoryItemModel: Codable {
        public let items: [CategoryItemModel]?
    }

    public struct CategoryItemModel: Codable {
        public let id: String
        public let icons: [ImageItemModel]?
        public let name: String
    }
}
