//
//  APIConfig.swift
//  RRCore
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

public enum Header {
    public static let ContentType = "Content-Type"
    public static let Accept = "Accept"
    public static let Authorization = "Authorization"
    public static let ApplicationFormUrlencoded = "application/x-www-form-urlencoded"
    public static let ApplicationFormData = "application/form-data"
    public static let ApplicationJson = "application/json"
    public static let MultipartFormData = "multipart/form-data"
    public static let TextHtml = "text/html"
    public static let Language = "Accept-Language"
    public static let APIKey = "x-api-key"
    public static let AuthorizationCode = "authorization_code"
    public static let RefreshToken = "refresh_token"

    public static let DeviceName = "DeviceName"
    public static let Platform = "Platform"
    public static let Identifier = "Identifier"
    public static let AppName = "AppName"
    public static let Version = "Version"
}

public struct URLEnvironment {
    public var url: String
    public var baseAuthorizeUrl: String
    public var clientId: String
    public var clientSecretId: String
    public var redirectUri: String

    public init(
        baseUrl: String,
        baseAuthorizeUrl: String,
        clientId: String,
        clientSecretId: String,
        redirectUri: String)
    {
        self.url = baseUrl
        self.baseAuthorizeUrl = baseAuthorizeUrl
        self.clientId = clientId
        self.clientSecretId = clientSecretId
        self.redirectUri = redirectUri
    }
}

public class APIConfig {
    public static let shared = APIConfig()

    private init() {}
    private var _baseUrl: URLEnvironment!

    public func configure(baseUrl: URLEnvironment) {
        _baseUrl = baseUrl
    }

    public var urlEnviroment: URLEnvironment {
        return _baseUrl
    }
}
