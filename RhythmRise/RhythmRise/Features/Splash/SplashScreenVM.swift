//
//  SplashScreenVM.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Combine
import Foundation
import RRAPILayer

final class SplashScreenVM: BaseViewModel {
    var onNextScreen = PassthroughSubject<AppRouter.AppFlow, Never>()

    func checkAppState() {
        if AppDataManager.shared.userContext.userAccessToken.isEmpty {
            onNextScreen.send(.login)
        } else {
            if AppDataManager.shared.userContext.isSessionExpired {
                apiRefreshToken()
            } else {
                onNextScreen.send(.mainTab)
            }
        }
    }

    private func apiRefreshToken() {
        let refreshToken = AppDataManager.shared.userContext.userRefreshToken
        let params = RefreshTokenEndpoint.Request(refreshToken: refreshToken)

        RefreshTokenEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                AppDataManager.shared.userContext.saveUserAccessToken(response.accessToken)
                AppDataManager.shared.userContext.saveExpirationTime(response.expireIn)
                self.onNextScreen.send(.mainTab)
            }.store(in: &cancellableSet)
    }
}
