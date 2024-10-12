//
//  SingleBrowseCategoryVM.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

final class SingleBrowseCategoryVM: BaseViewModel {
    private var browseCategory: BrowseCategoryItemViewData

    init(_ browseCategory: BrowseCategoryItemViewData) {
        self.browseCategory = browseCategory
    }

    func loadData() {
        apiGetSingleBrowseCategory()
    }

    private func apiGetSingleBrowseCategory() {
        let params = GetSingleBrowseCategoryEndpoint.Request()
        GetSingleBrowseCategoryEndpoint.service(browseCategory.id)
            .request(parameters: params)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.handleError(error)
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
            }.store(in: &cancellableSet)
    }
}
