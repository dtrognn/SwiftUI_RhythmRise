//
//  AuthManager.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    enum Scope: String, CaseIterable {
        case userReadPrivate = "user-read-private"
        case userReadEmail = "user-read-email"
        case userFollowRead = "user-follow-read"
        case userLibraryModify = "user-library-modify"
        case userLibraryRead = "user-library-read"
        case userTopRead = "user-top-read"
        case userReadRecentlyPlayed = "user-read-recently-played"
        case playlistModifyPublic = "playlist-modify-public"
        case playlistModifyPrivate = "playlist-modify-private"
        case playlistReadPrivate = "playlist-read-private"
    }

    private let clientId = AppDefineConfiguration.clientID
    private let authorizeUrl = AppDefineConfiguration.baseAuthorizeUrl
    private let redirectUris = AppDefineConfiguration.redirectURIs
    private let scopes: [Scope] = Scope.allCases

    var signInUrl: URL? {
        let scopesFormat: String = scopes.map { $0.rawValue }.joined(separator: "%20")
        let string = "\(authorizeUrl)/authorize?response_type=code&client_id=\(clientId)&scope=\(scopesFormat)&redirect_uri=\(redirectUris)&show_dialog=TRUE"

        return URL(string: string)
    }
}
