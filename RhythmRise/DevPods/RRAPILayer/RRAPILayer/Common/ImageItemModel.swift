//
//  ImageItemModel.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

public struct ImageItemModel: Codable {
    public let url: String
    public let width: Int
    public let height: Int

    public enum CodingKeys: String, CodingKey {
        case url, width, height
    }

    public init(url: String, width: Int, height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}
