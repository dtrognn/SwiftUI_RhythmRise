//
//  EpisodeItemData.swift
//  RRAPILayer
//
//  Created by dtrognn on 19/10/24.
//

import Foundation

public struct EpisodeItemData: Codable {
    public let id: String
    public let name: String
    public let description: String
    public let uri: String
    public let type: String
    public let audioPreviewUrl: String
    public let resumePoint: ResumePoint
    public let durationMs: Int
    public let images: [ImageItemModel]?
    public let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case uri
        case type
        case audioPreviewUrl = "audio_preview_url"
        case resumePoint = "resume_point"
        case durationMs = "duration_ms"
        case images
        case releaseDate = "release_date"
    }
}

public struct ResumePoint: Codable {
    public let resumePositionMs: Int
    public let fullyPlayed: Bool

    enum CodingKeys: String, CodingKey {
        case resumePositionMs = "resume_position_ms"
        case fullyPlayed = "fully_played"
    }
}
