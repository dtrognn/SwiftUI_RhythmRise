//
//  EpisodeItemViewData.swift
//  RhythmRise
//
//  Created by dtrognn on 19/10/24.
//

import Foundation
import RRAPILayer

class EpisodeItemViewData: Identifiable, ObservableObject {
    var id: String = UUID().uuidString
    var name: String = ""
    var des: String = ""
    var uri: String = ""
    var audioPreviewUrl: String = ""
    var resumePoint: ResumePointData = .init()
    var durationMs: Int = 0
    var images: [ImageData] = []
    var releaseDate: String = ""

    init() {}

    init(_ episode: EpisodeItemData) {
        self.id = episode.id
        self.name = episode.name
        self.des = episode.description
        self.uri = episode.uri
        self.audioPreviewUrl = episode.audioPreviewUrl
        self.resumePoint = ResumePointData(episode.resumePoint)
        self.durationMs = episode.durationMs
        self.images = episode.images?.map { ImageData($0) } ?? []
        self.releaseDate = episode.releaseDate
    }
}

extension EpisodeItemViewData: IMediaItemData {
    var type: MediaType {
        return .episode
    }

    var description: String? {
        return des
    }

    var imageUrl: String {
        return images.first?.url ?? ""
    }

    var previewUrl: String {
        return audioPreviewUrl
    }

    func mapData(_ data: Any) {
        if let episode = data as? EpisodeItemData {
            update(id: episode.id,
                   name: episode.name,
                   description: episode.description,
                   uri: episode.uri,
                   audioPreviewUrl: episode.audioPreviewUrl,
                   resumePoint: ResumePointData(episode.resumePoint),
                   durationMs: episode.durationMs,
                   images: episode.images?.map { ImageData($0) } ?? [],
                   releaseDate: episode.releaseDate)
        }
    }

    private func update(id: String, name: String, description: String, uri: String, audioPreviewUrl: String, resumePoint: ResumePointData, durationMs: Int, images: [ImageData], releaseDate: String) {
        self.id = id
        self.name = name
        self.des = description
        self.uri = uri
        self.audioPreviewUrl = audioPreviewUrl
        self.resumePoint = resumePoint
        self.durationMs = durationMs
        self.images = images
        self.releaseDate = releaseDate
    }
}

class ResumePointData {
    var resumePositionMs: Int = 0
    var fullyPlayed: Bool = false

    init() {}

    init(_ resomePoint: ResumePoint) {
        self.resumePositionMs = resomePoint.resumePositionMs
        self.fullyPlayed = resomePoint.fullyPlayed
    }
}
