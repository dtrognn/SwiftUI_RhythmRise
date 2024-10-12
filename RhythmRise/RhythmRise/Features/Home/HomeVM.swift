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
    @Published var favouriteArtists: [ArtistItemViewData] = []

    private var isLoadFirst: Bool = true

    func loadData() {
        if isLoadFirst {
            isLoadFirst = false
            apiGetCurrentUserInfo()
            getTopArtists()
        }
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

    private func getTopArtists() {
        let params = GetUsersTopItemsEndpoint.Request()
        GetUsersTopItemsEndpoint.service(type: .artists).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let artists = response.items else {
                    return
                }
                self.favouriteArtists = artists.map { ArtistItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
