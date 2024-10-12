//
//  FavouriteArtistsView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct FavouriteArtistsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var favouriteArtists: [ArtistItemViewData]
    private var onSelect: (ArtistItemViewData) -> Void

    init(_ favouriteArtists: [ArtistItemViewData], onSelect: @escaping (ArtistItemViewData) -> Void) {
        self.favouriteArtists = favouriteArtists
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            yourFavouriteArtistsText
                .padding(.leading, themeManager.layout.standardSpace)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: themeManager.layout.standardSpace) {
                    ForEach(favouriteArtists) { artist in
                        FavouriteArtistItemView(artist) { artistSelected in
                            onSelect(artistSelected)
                        }
                    }
                }.padding(.leading, themeManager.layout.standardSpace)
            }.fixedSize(horizontal: false, vertical: true)
        }
    }
}

private extension FavouriteArtistsView {
    var yourFavouriteArtistsText: some View {
        return Text(language("Home_A_01"))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}
