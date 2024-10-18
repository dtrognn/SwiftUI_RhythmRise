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
    @Published var mediaTypes: [MediaType] = []

    private var isLoadFirst: Bool = true

    override init() {
        super.init()
    }

    func loadData() {
        if isLoadFirst {
            isLoadFirst = false
            apiGetUsersSavedShows()
            apiGetUsersSavedAlbums()
        }
    }

    private func updateMediaTypes() {
        mediaTypes = Array(Set(recents.map { $0.type }))
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

                guard let itemsResponse = response.items else { return }
                let itemsMapping = itemsResponse.map {
                    MediaFactory.mapping(type: .show, data: $0.show)
                }
                let items = itemsMapping.map { MediaItemViewData($0) }

                items.forEach {
                    self.recents.append($0)
                }
                self.updateMediaTypes()
            }.store(in: &cancellableSet)
    }

    // TODO: - get user's saved albums
    private func apiGetUsersSavedAlbums() {
        let params = GetUsersSavedAlbumsEndpoint.Request(limit: 50)
        GetUsersSavedAlbumsEndpoint.service.request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let itemsRespopnse = response.items else { return }
                let itemsMapping = itemsRespopnse.map {
                    MediaFactory.mapping(type: .album, data: $0.album)
                }
                let items = itemsMapping.map { MediaItemViewData($0) }

                items.forEach {
                    self.recents.append($0)
                }
                self.updateMediaTypes()
            }.store(in: &cancellableSet)
    }
}
