//
//  Endpoint.swift
//  RRCore
//
//  Created by dtrognn on 10/10/24.
//

import Combine
import Foundation

public enum URLType {
    case authorization
    case API
}

public protocol Endpoint {
    associatedtype Request: Codable
    associatedtype Response: Codable

    var path: String { get }
    var method: HTTPMethod { get }
    var onlyUseHeadersDefault: Bool { get }
    var headers: [String: String]? { get }
    var token: String { get }
    var refreshToken: String { get }
    var urlTypeUsed: URLType { get set }
}

public extension Endpoint {
    var onlyUseHeadersDefault: Bool {
        return false
    }

    var token: String {
        return bearerToken("")
    }

    var refreshToken: String {
        return ""
    }

    var urlTypeUsed: URLType {
        return .API
    }

    func request(parameters: Request) -> AnyPublisher<Response, APIError> {
        var params = [String: Any]()
        do { params = try parameters.asDictionary() } catch {}
        return API.call(endpoint: self, parameters: params)
    }

    private func bearerToken(_ token: String) -> String {
        return "Bearer \(token)"
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}
