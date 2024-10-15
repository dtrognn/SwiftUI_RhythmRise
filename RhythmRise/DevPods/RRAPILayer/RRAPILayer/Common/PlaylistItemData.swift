//
//  PlaylistItemData.swift
//  RRAPILayer
//
//  Created by dtrognn on 15/10/24.
//

import Foundation

public struct PlaylistItemData: Codable {
    public let id: String
    public let name: String
    public let images: [ImageItemModel]?
    public let description: String

    enum CodingKeys: String, CodingKey {
        case id, name, images, description
    }
}
