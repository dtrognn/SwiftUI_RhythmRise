//
//  AuthVM.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import Foundation
import RRAPILayer

final class AuthVM: BaseViewModel {
    func requestAccessToken(from authorization: String) {
        print("AuthVM authorization code: \(authorization)")
        showLoading(true)
        let params = GetAccessTokenEndpoint.Request(code: authorization)
        GetAccessTokenEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.showLoading(false)
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.showLoading(false)

                AppDataManager.shared.userContext.saveAuthorizeInfo(
                    userAccessToken: response.accessToken,
                    userRefreshToken: response.refreshToken,
                    expireIn: response.expireIn)
                AppDataManager.shared.updateLoginState(true)

                print("AuthVM access token: \(response.accessToken)")
                print("AuthVM expire in: \(response.expireIn)")
                print("AuthVM refresh token: \(response.refreshToken)")
            }.store(in: &cancellableSet)
    }
}
