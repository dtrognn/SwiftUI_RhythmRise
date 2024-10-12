//
//  ImageData.swift
//  RhythmRise
//
//  Created by dtrognn on 11/10/24.
//

import Foundation
import RRAPILayer

struct ImageData {
    let url: String
    let width: Int
    let height: Int

    init(_ image: ImageItemModel) {
        self.url = image.url
        self.width = image.width
        self.height = image.height
    }
}
