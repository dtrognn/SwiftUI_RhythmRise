//
//  BrowseCategoryItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct BrowseCategoryItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var media: MediaItemViewData
    private var onSelect: (MediaItemViewData) -> Void

    init(_ media: MediaItemViewData, onSelect: @escaping (MediaItemViewData) -> Void) {
        self.media = media
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect(media)
        } label: {
            VStack {
                VStack(spacing: themeManager.layout.zero) {
                    HStack {
                        Spacer()
                        imageView
                    }.padding(.top, themeManager.layout.largeSpace)
                }.overlay(titleText, alignment: .topLeading)
            }
            .background(Color.random)
            .cornerRadius(themeManager.layout.standardCornerRadius)
        }
    }
}

private extension BrowseCategoryItemView {
    var titleText: some View {
        return Text(media.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textWhiteColor)
            .padding([.leading, .vertical], themeManager.layout.standardSpace)
    }

    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: media.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 60, height: 60)
            .cornerRadius(themeManager.layout.standardCornerRadius)
            .rotationEffect(.degrees(25))
            .offset(x: 15)
            .frame(maxHeight: .infinity, alignment: .bottomTrailing)
    }
}
