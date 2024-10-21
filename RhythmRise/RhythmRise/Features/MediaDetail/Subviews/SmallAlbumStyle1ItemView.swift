//
//  SmallAlbumStyle1ItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct SmallAlbumStyle1ItemView: View {
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
            HStack(spacing: themeManager.layout.standardSpace) {
                imageView
                VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                    albumNameText
                    descriptionText
                }
                Spacer()
            }
        }
    }
}

private extension SmallAlbumStyle1ItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: media.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 75, height: 75)
    }

    var albumNameText: some View {
        return Text(media.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var descriptionText: some View {
        return Text(media.getArtistsFormat())
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
