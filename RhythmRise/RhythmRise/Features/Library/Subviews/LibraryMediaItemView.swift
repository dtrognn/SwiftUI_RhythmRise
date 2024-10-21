//
//  LibraryMediaItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 18/10/24.
//

import RRCommon
import SwiftUI

struct LibraryMediaItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var media: MediaItemViewData
    private var onSelect: ((MediaItemViewData) -> Void)?

    init(_ media: MediaItemViewData, onSelect: ((MediaItemViewData) -> Void)? = nil) {
        self.media = media
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(media)
        } label: {
            HStack(spacing: themeManager.layout.zero) {
                HStack(spacing: themeManager.layout.standardSpace) {
                    imageView

                    VStack(alignment: .leading, spacing: themeManager.layout.smallSpace) {
                        titleText
                        descriptionText
                    }
                }
                Spacer()
            }
        }
    }
}

private extension LibraryMediaItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: media.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 50, height: 50)
            .cornerRadius(themeManager.layout.standardCornerRadius)
    }

    var titleText: some View {
        return Text(media.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var descriptionText: some View {
        return Text(String(format: "%@ • %@", language(media.type.title), media.getArtistsFormat()))
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineLimit(1)
    }
}
