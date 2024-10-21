//
//  ShowItemData.swift
//  RRAPILayer
//
//  Created by dtrognn on 18/10/24.
//

import Foundation

public struct ShowItemData: Codable {
    public let id: String
    public let name: String
    public let description: String
    public let type: String
    public let mediaType: String
    public let uri: String
    public let publisher: String
    public let images: [ImageItemModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case type
        case mediaType = "media_type"
        case uri
        case publisher
        case images
    }
}
