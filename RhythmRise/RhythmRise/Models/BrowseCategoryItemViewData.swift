//
//  BrowseCategoryItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

struct BrowseCategoryItemViewData: Identifiable {
    var id: String
    var name: String
    var images: [ImageData]

    init(_ category: GetSeveralBrowseCategoriesEndpoint.CategoryItemModel) {
        self.id = category.id
        self.name = category.name
        self.images = category.icons?.map { ImageData($0) } ?? []
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }
}
