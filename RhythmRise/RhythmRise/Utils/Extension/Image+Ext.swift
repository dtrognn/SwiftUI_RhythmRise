//
//  Image+Ext.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

extension Image {
    static func image(_ name: String) -> Image {
        return Image(name, bundle: .main)
    }
}
