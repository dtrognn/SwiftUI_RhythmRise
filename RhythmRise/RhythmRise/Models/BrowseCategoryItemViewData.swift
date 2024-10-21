//
//  BrowseCategoryItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import Foundation
import RRAPILayer

class BrowseCategoryItemViewData: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String = ""
    var images: [ImageData] = []

    static func == (lhs: BrowseCategoryItemViewData, rhs: BrowseCategoryItemViewData) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init() {}

    init(_ category: GetSeveralBrowseCategoriesEndpoint.CategoryItemModel) {
        self.id = category.id
        self.name = category.name
        self.images = category.icons?.map { ImageData($0) } ?? []
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }
}

extension BrowseCategoryItemViewData: IMediaItemData {
    var type: MediaType {
        return .browseCatgory
    }

    var previewUrl: String {
        return ""
    }

    func mapData(_ data: Any) {
        if let category = data as? GetSeveralBrowseCategoriesEndpoint.CategoryItemModel {
            update(id: category.id,
                   name: category.name,
                   images: category.icons?.map { ImageData($0) } ?? [])
        }
    }

    private func update(id: String, name: String, images: [ImageData]) {
        self.id = id
        self.name = name
        self.images = images
    }
}
