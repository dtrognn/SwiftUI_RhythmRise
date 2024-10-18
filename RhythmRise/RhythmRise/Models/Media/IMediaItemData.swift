//
//  IMediaItemData.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

enum MediaType {
    case track
    case artist
    case album
    case playlist
    case browseCatgory
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
