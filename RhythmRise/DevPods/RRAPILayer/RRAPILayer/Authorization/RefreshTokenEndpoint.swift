//
//  RefreshTokenEndpoint.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRCore

public struct RefreshTokenEndpoint: Endpoint {
    public static let service = RefreshTokenEndpoint()

    public var path: String = "/api/token"
    public var method: HTTPMethod = .POST
    public var onlyUseHeadersDefault: Bool = true
    public var urlTypeUsed: URLType = .authorization

    public var headers: [String: String]? {
        return [
            Header.ContentType: Header.ApplicationFormUrlencoded,
            Header.Authorization: getAuthorizationCode()
        ]
    }

    private func getAuthorizationCode() -> String {
        let clientId = APIConfig.shared.urlEnviroment.clientId
        let clientSecretId = APIConfig.shared.urlEnviroment.clientSecretId

        let basicToken = String(format: "%@:%@", clientId, clientSecretId)
        let data = basicToken.data(using: .utf8)
        let base64String = data?.base64EncodedString() ?? ""

        return "Basic \(base64String)"
    }

    public struct Request: Codable {
        public let grandType: String
        public let refreshToken: String

        public init(grandType: String = Header.RefreshToken, refreshToken: String) {
            self.grandType = grandType
            self.refreshToken = refreshToken
        }

        enum CodingKeys: String, CodingKey {
            case grandType = "grant_type"
            case refreshToken = "refresh_token"
        }
    }

    public struct Response: Codable {
        public let accessToken: String
        public let tokenType: String?
        public let scope: String?
        public let expireIn: Int

        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
            case expireIn = "expires_in"
        }
    }
}
