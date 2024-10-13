//
//  UserContext.swift
//  RRAuthentication
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

private class User {
    public var id: String = UUID().uuidString
    public var product: String = ""
    public var email: String = ""
    public var displayName: String = ""
    public var imageUrl: String = ""

    public init() {}
}

public final class UserContext {
    public static let shared = UserContext()
    private var user = User()

    public var userId: String { user.id }
    public var email: String { user.email }
    public var displayName: String { user.displayName }
    public var imageUrl: String { user.imageUrl }

    public var userAccessToken: String = ""
    public var userRefreshToken: String = ""
    private var expirationTime: Int = 0

    private let USER_ID_KEY = "USER_ID_KEY"
    private let USER_EMAIL_KEY = "USER_EMAIL_KEY"
    private let USER_DISPLAY_NAME_KEY = "USER_DISPLAY_NAME_KEY"
    private let USER_IMAGE_URL_KEY = "USER_IMAGE_URL_KEY"
    private let USER_ACCESS_TOKEN_KEY = "USER_ACCESS_TOKEN_KEY"
    private let USER_REFRESH_ACCESS_TOKEN_KEY = "USER_REFRESH_ACCESS_TOKEN_KEY"
    private let SESSION_EXPIRED_KEY = "SESSION_EXPIRED_KEY"

    private init() {
        user = User()

        user.displayName = getStorage(with: USER_DISPLAY_NAME_KEY) ?? ""

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

    public func saveUserInfo(id: String, email: String, displayName: String, imageUrl: String) {
        saveUserId(id)
        saveUserEmail(email)
        saveUserDisplayName(displayName)
        saveUserImageUrl(imageUrl)
    }

    public func saveUserId(_ userId: String) {
        user.id = userId
        setStorage(value: userId, forKey: USER_ID_KEY)
    }

    public func saveUserEmail(_ email: String) {
        user.email = email
        setStorage(value: email, forKey: USER_EMAIL_KEY)
    }

    public func saveUserDisplayName(_ displayName: String) {
        user.displayName = displayName
        setStorage(value: displayName, forKey: USER_DISPLAY_NAME_KEY)
    }

    public func saveUserImageUrl(_ imageUrl: String) {
        user.imageUrl = imageUrl
        setStorage(value: imageUrl, forKey: USER_IMAGE_URL_KEY)
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
