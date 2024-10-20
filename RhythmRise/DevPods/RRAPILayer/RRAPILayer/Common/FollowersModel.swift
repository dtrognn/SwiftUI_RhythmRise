//
//  FollowersModel.swift
//  RRAPILayer
//
//  Created by dtrognn on 11/10/24.
//

import Foundation

public struct FollowersModel: Codable {
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case total
    }
}
