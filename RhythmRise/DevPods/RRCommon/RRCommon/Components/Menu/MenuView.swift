//
//  MenuView.swift
//  RRCommon
//
//  Created by dtrognn on 10/10/24.
//

import SwiftUI

public struct MenuView<Content: View>: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var configuration: MenuConfiguration
    private var content: () -> Content

    public init(_ configuration: MenuConfiguration, content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
    }

    public var body: some View {
        Menu {
            ForEach(configuration.menuItemList) { menuItem in
                Button {
                    Vibration.selection.vibrate()
                    configuration.onSelect(menuItem)
                } label: {
                    HStack(spacing: themeManager.layout.standardSpace) {
                        HStack(spacing: themeManager.layout.mediumSpace) {
                            if let leadingImage = menuItem.leadingImage {
                                leadingImage
                            }

                            Text(menuItem.title)
                                .font(themeManager.font.regular12)
                                .foregroundStyle(themeManager.theme.textNormalColor)
                        }

                        if let trailingImage = menuItem.trailingImage {
                            if menuItem.isUseTheme {
                                trailingImage.applyTheme()
                            } else {
                                trailingImage
                            }
                        }
                    }
                }
            }
        } label: {
            content()
        }
    }
}
