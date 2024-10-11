//
//  AuthManager.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    enum Scope: String {
        case userReadPrivate = "user-read-private"
        case userReadEmail = "user-read-email"
    }

    private let clientId = AppDefineConfiguration.clientID
    private let authorizeUrl = AppDefineConfiguration.baseAuthorizeUrl
    private let redirectUris = AppDefineConfiguration.redirectURIs
    private let scopes: [Scope] = [.userReadPrivate]

    var signInUrl: URL? {
        let scopesFormat: String = scopes.map { $0.rawValue }.joined(separator: " ")
        let string = "\(authorizeUrl)/authorize?response_type=code&client_id=\(clientId)&scope=\(scopesFormat)&redirect_uri=\(redirectUris)&show_dialog=TRUE"

        return URL(string: string)
    }
}
