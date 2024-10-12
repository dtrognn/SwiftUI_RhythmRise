//
//  GetSeveralArtistsEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRCore

public struct GetSeveralArtistsEndpoint: Endpoint {
    public static let service = GetSeveralArtistsEndpoint()

    public var path: String = "/v1/artists"
    public var method: HTTPMethod = .GET
    public var headers: [String : String]? = nil

    public struct Request: Codable {

    }

    public struct Response: Codable {

    }
}
