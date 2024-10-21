//
//  ArtistItemModel.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

public struct ArtistItemModel: Codable {
    public let id: String
    public let genres: [String]?
    public let images: [ImageItemModel]?
    public let followers: FollowersModel?
    public let popularity: Int?
    public let type: String?
    public let name: String
}
