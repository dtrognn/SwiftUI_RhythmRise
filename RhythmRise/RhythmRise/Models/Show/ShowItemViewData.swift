//
//  ShowItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import Foundation
import RRAPILayer

class ShowItemViewData: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String = ""
    var description: String = ""
    var mediaType: String = ""
    var uri: String = ""
    var publisher: String = ""
    var images: [ImageData] = []

    init() {}

    init(_ show: ShowItemData) {
        self.id = show.id
        self.name = show.name
        self.description = show.description
        self.mediaType = show.mediaType
        self.uri = show.uri
        self.publisher = show.publisher
        self.images = show.images?.map { ImageData($0) } ?? []
    }
}

extension ShowItemViewData: IMediaItemData {
    var type: MediaType {
        return .show
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }

    var previewUrl: String {
        return ""
    }

    func mapData(_ data: Any) {
        if let show = data as? ShowItemData {
            update(id: show.id,
                   name: show.name,
                   description: show.description,
                   mediaType: show.mediaType,
                   uri: show.uri,
                   publisher: show.publisher,
                   images: show.images?.map { ImageData($0) } ?? [])
        } else if let show = data as? GetShowEndpoint.Response {
            update(id: show.id,
                   name: show.name,
                   description: show.description,
                   mediaType: "",
                   uri: show.uri,
                   publisher: show.publisher,
                   images: show.images?.map { ImageData($0) } ?? [])
        }
    }

    private func update(id: String, name: String, description: String, mediaType: String, uri: String, publisher: String, images: [ImageData]) {
        self.id = id
        self.name = name
        self.description = description
        self.mediaType = mediaType
        self.uri = uri
        self.publisher = publisher
        self.images = images
    }
}
