//
//  IPlayerMedia.swift
//  RhythmRise
//
//  Created by dtrognn on 14/10/24.
//

import Foundation

enum PlayerMediaType {
    case artist
    case album
    case playlist
}

protocol IPlayerMedia {
    var id: String { get }
    var type: PlayerMediaType { get }
    var name: String { get }
    var description: String? { get }
    var imageUrl: String { get }
    var previewUrl: String { get }

    func mapData(_ data: Any)
}

extension IPlayerMedia {
    var description: String? {
        return nil
    }
}
