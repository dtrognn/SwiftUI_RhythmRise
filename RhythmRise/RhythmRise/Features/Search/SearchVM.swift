//
//  SearchVM.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

final class SearchVM: BaseViewModel {
    @Published var severalBrowseCategories: [MediaItemViewData] = []

    private var isLoadFirst: Bool = true

    func loadData() {
        if isLoadFirst {
            isLoadFirst = false
            apiGetSeveralBrowseCategories()
        }
    }

    private func apiGetSeveralBrowseCategories() {
        let parasm = GetSeveralBrowseCategoriesEndpoint.Request(limit: 20)
        GetSeveralBrowseCategoriesEndpoint.service.request(parameters: parasm)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard let items = response.categories.items else { return }
                let browseCategoriesMapping = items.map {
                    MediaFactory.mapping(type: .browseCatgory, data: $0)
                }
                self.severalBrowseCategories = browseCategoriesMapping.map { MediaItemViewData($0) }
            }.store(in: &cancellableSet)
    }
}
