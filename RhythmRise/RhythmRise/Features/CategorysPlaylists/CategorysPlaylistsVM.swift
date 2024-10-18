//
//  CategorysPlaylistsVM.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRAPILayer

final class CategorysPlaylistsVM: BaseViewModel {
    @Published var sectionPlaylists: SectionPlaylistsItemData?

    private var categoryId: String

    init(_ categoryId: String) {
        self.categoryId = categoryId
    }

    func loadData() {
        apiGetCategorysPlaylists()
    }
}

// MARK: - API

extension CategorysPlaylistsVM {
    // TODO: - get category's playlists
    private func apiGetCategorysPlaylists() {
        let params = GetCategorysPlaylistsEndpoint.Request(limit: 10)
        GetCategorysPlaylistsEndpoint.service(categoryId).request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.playlists.items else { return }
                let playlistsMapping = items.map {
                    MediaFactory.mapping(type: .playlist, data: $0)
                }
                let playlists = playlistsMapping.map { MediaItemViewData($0) }
                self.sectionPlaylists = SectionPlaylistsItemData(message: response.message, playlists: playlists)
            }.store(in: &cancellableSet)
    }
}
