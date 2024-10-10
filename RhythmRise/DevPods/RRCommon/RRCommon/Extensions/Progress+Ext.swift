//
//  Progress+Ext.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

public extension ProgressView {
    func applyTheme(_ color: Color = ThemeManager.shared.theme.iconColor) -> some View {
        self.foregroundColor(color)
    }
}
