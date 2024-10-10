//
//  Image+Ext.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

extension Image {
    func image(_ resource: String) -> Image {
        return Image(resource, bundle: .main)
    }
}
