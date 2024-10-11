//
//  GetAccessTokenEndpoint.swift
//  Pods
//
//  Created by dtrognn on 10/10/24.
//

import Foundation
import RRCore

public struct GetAccessTokenEndpoint: Endpoint {
    public static let service = GetAccessTokenEndpoint()

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
        public let code: String
        public let redirectUri: String

        public init(
            grandType: String = "authorization_code",
            code: String,
            redirectUri: String = APIConfig.shared.urlEnviroment.redirectUri)
        {
            self.grandType = grandType
            self.code = code
            self.redirectUri = redirectUri
        }

        enum CodingKeys: String, CodingKey {
            case grandType = "grant_type"
            case code
            case redirectUri = "redirect_uri"
        }
    }

    public struct Response: Codable {
        public let accessToken: String
        public let tokenType: String?
        public let scope: String?
        public let expireIn: Int
        public let refreshToken: String

        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
            case expireIn = "expires_in"
            case refreshToken = "refresh_token"
        }
    }
}
