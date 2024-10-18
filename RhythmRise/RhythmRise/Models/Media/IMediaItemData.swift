//
//  IMediaItemData.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

enum MediaType: String {
    case track
    case artist
    case album
    case playlist
    case browseCatgory
    case show

    var title: String {
        return switch self {
        case .track:
            "Media_Type_A_01"
        case .artist:
            "Media_Type_A_02"
        case .album:
            "Media_Type_A_03"
        case .playlist:
            "Media_Type_A_04"
        case .browseCatgory:
            ""
        case .show:
            "Media_Type_A_05"
        }
    }
}

protocol IMediaItemData {
    var id: String { get }
    var type: MediaType { get }
    var name: String { get }
    var description: String? { get }
    var imageUrl: String { get }
    var previewUrl: String { get }

    func mapData(_ data: Any)
}

extension IMediaItemData {
    var description: String? {
        return nil
    }
}
