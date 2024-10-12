//
//  FavouriteArtistItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct FavouriteArtistItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var artist: ArtistItemViewData
    private var onSelect: (ArtistItemViewData) -> Void

    init(_ artist: ArtistItemViewData, onSelect: @escaping (ArtistItemViewData) -> Void) {
        self.artist = artist
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .center, spacing: themeManager.layout.mediumSpace) {
            Button {
                Vibration.selection.vibrate()
                onSelect(artist)
            } label: {
                imageView
            }

            artistNameText
        }
    }
}

private extension FavouriteArtistItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: artist.imageLargeUrl), contentMode: .fill) {
            ProgressView().applyTheme()
        }.frame(width: 135, height: 135)
            .clipShape(.circle)
    }

    var artistNameText: some View {
        return Text(artist.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }
}
