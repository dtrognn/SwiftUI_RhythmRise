//
//  CheckUsersSavedShows.swift
//  RRAPILayer
//
//  Created by dtrognn on 21/10/24.
//

import Foundation
import RRCore

public struct CheckUsersSavedShows: Endpoint {
    public static let service = CheckUsersSavedShows()

    public var path: String = "/v1/me/shows/contains"
    public var method: HTTPMethod = .GET
    public var headers: [String: String]? = nil

    public struct Request: Codable {
        public let ids: String

        public init(ids: String) {
            self.ids = ids
        }
    }

//    public struct Response: Codable {
//        public let result: [Bool]
//    }

    public typealias Response = [Bool]
}
