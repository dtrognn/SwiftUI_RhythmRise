//
//  LibraryVM.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRAPILayer

final class LibraryVM: BaseViewModel {
    @Published var recents: [MediaItemViewData] = []
    private var isLoadFirst: Bool = true

    override init() {
        super.init()
    }

    func loadData() {
        if isLoadFirst {
            isLoadFirst = false
            apiGetUsersSavedShows()
        }
    }
}

// MARK: - API

extension LibraryVM {
    // TODO: - get user's saved shows
    private func apiGetUsersSavedShows() {
        let params = GetUsersSavedShowsEndpoint.Request(limit: 50)
        GetUsersSavedShowsEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.items else { return }
                let itemsMapping = items.map {
                    MediaFactory.mapping(type: .show, data: $0.show)
                }
                self.recents = itemsMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
