//
//  ShowDetailVM.swift
//  RhythmRise
//
//  Created by dtrognn on 19/10/24.
//

import Foundation
import RRAPILayer

final class ShowDetailVM: BaseViewModel {
    private var id: String

    @Published var show: MediaItemViewData?
    @Published var episodes: [MediaItemViewData] = []
    @Published var isFollowing: Bool = false

    init(_ id: String) {
        self.id = id
    }

    func loadData() {
        apiGetShow()
        apiCheckUsersSavedShows()
    }
}

// MARK: - API

extension ShowDetailVM {
    // TODO: - get show
    private func apiGetShow() {
        let params = GetShowEndpoint.Request()
        GetShowEndpoint.service(id).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                let showMapping = MediaFactory.mapping(type: .show, data: response)
                self.show = MediaItemViewData(showMapping)

                guard let episodes = response.episodes.items else { return }
                let episodesMapping = episodes.map {
                    MediaFactory.mapping(type: .episode, data: $0)
                }
                self.episodes = episodesMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }

    // TODO: - check user's saved shows
    private func apiCheckUsersSavedShows() {
        let params = CheckUsersSavedShows.Request(ids: id)
        CheckUsersSavedShows.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                self.isFollowing = response.first ?? false
            }.store(in: &cancellableSet)
    }
}
