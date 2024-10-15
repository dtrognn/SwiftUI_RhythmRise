//
//  ArtistDetailAlbumItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct ArtistDetailAlbumItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var album: AlbumItemViewData
    private var onSelect: ((AlbumItemViewData) -> Void)?

    init(_ album: AlbumItemViewData, onSelect: ((AlbumItemViewData) -> Void)? = nil) {
        self.album = album
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(album)
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

private extension ArtistDetailAlbumItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: album.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 75, height: 75)
    }

    var albumNameText: some View {
        return Text(album.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var descriptionText: some View {
        return Text(album.artists.map { $0.name }.joined(separator: ", "))
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
