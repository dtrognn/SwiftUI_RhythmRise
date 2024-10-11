//
//  UserContext.swift
//  RRAuthentication
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

private class User {
    public var id: Int = 0
    public var email: String = ""

    public init() {}
}

public final class UserContext {
    public static let shared = UserContext()
    private var user = User()

    public var userAccessToken: String = ""
    public var userRefreshToken: String = ""
    private var expirationTime: Int = 0

    private let USER_ACCESS_TOKEN_KEY = "USER_ACCESS_TOKEN_KEY"
    private let USER_REFRESH_ACCESS_TOKEN_KEY = "USER_REFRESH_ACCESS_TOKEN_KEY"
    private let SESSION_EXPIRED_KEY = "SESSION_EXPIRED_KEY"

    private init() {
        user = User()

        userAccessToken = getStorage(with: USER_ACCESS_TOKEN_KEY) ?? ""
        userRefreshToken = getStorage(with: USER_REFRESH_ACCESS_TOKEN_KEY) ?? ""
        expirationTime = getStorage(with: SESSION_EXPIRED_KEY) ?? Date().timeIntervalSince1970.toInt()
    }

    public var isSessionExpired: Bool {
        return Date().timeIntervalSince1970.toInt() >= expirationTime
    }

    public func logout() {
        clearCacheData()
    }

    public func saveAuthorizeInfo(userAccessToken: String, userRefreshToken: String, expireIn: Int) {
        saveUserAccessToken(userAccessToken)
        saveUserRefreshToken(userRefreshToken)
        saveExpirationTime(expireIn)
    }

    public func saveUserAccessToken(_ accessToken: String) {
        userAccessToken = accessToken
        setStorage(value: accessToken, forKey: USER_ACCESS_TOKEN_KEY)
    }

    public func saveUserRefreshToken(_ refreshToken: String) {
        userRefreshToken = refreshToken
        setStorage(value: refreshToken, forKey: USER_REFRESH_ACCESS_TOKEN_KEY)
    }

    public func saveExpirationTime(_ expireIn: Int) {
        let expirationDate = Date().addingTimeInterval(TimeInterval(expireIn))
        let expirationTime = expirationDate.timeIntervalSince1970.toInt()

        self.expirationTime = expirationTime
        setStorage(value: expirationTime, forKey: SESSION_EXPIRED_KEY)
    }

    private func clearCacheData() {
        user = User()
        saveExpirationTime(0)
        saveUserAccessToken("")
        saveUserRefreshToken("")
    }
}

private extension UserContext {
    private func setStorage(value: Int, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }

    private func setStorage(value: String, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }

    private func getStorage(with key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    private func getStorage(with key: String) -> Int? {
        return UserDefaults.standard.integer(forKey: key)
    }
}

private extension Double {
    func toInt() -> Int {
        return Int(self)
    }
}
