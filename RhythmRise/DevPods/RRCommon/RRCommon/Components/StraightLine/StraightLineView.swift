//
//  StraightLineView.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

public struct StraightLineView: View {
    public init() {}

    public var body: some View {
        Divider().frame(height: 1)
            .overlay(ThemeManager.shared.theme.textNoteColor)
    }
}
