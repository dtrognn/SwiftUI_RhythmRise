//
//  BrowseCategoryItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class BrowseCategoryItemViewData: Identifiable, Hashable {
    var id: String
    var name: String
    var images: [ImageData]

    static func == (lhs: BrowseCategoryItemViewData, rhs: BrowseCategoryItemViewData) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(_ category: GetSeveralBrowseCategoriesEndpoint.CategoryItemModel) {
        self.id = category.id
        self.name = category.name
        self.images = category.icons?.map { ImageData($0) } ?? []
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }
}
