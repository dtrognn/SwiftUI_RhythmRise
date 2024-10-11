//
//  HomeVM.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRAPILayer

final class HomeVM: BaseViewModel {
    @Published var userAvatarUrl: String = ""

    func loadData() {
        apiGetCurrentUserInfo()
    }

    private func apiGetCurrentUserInfo() {
        showLoading(true)

        let params = GetCurrentUserInfoEndpoint.Request()
        GetCurrentUserInfoEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.showLoading(false)
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.showLoading(false)

                guard let avatar = response.images?.first else { return }
                self.userAvatarUrl = avatar.url
            }.store(in: &cancellableSet)
    }
}
