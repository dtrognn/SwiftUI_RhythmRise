//
//  NewReleasesView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct NewReleasesView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var newReleases: [AlbumItemViewData]
    private var onSelect: ((AlbumItemViewData) -> Void)?

    init(_ newReleases: [AlbumItemViewData], onSelect: ((AlbumItemViewData) -> Void)? = nil) {
        self.newReleases = newReleases
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            newReleaseText.padding(.leading, themeManager.layout.standardSpace)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: themeManager.layout.standardSpace) {
                    ForEach(newReleases) { album in
                        NewReleaseItemView(album) { albumSelected in
                            onSelect?(albumSelected)
                        }
                    }
                }.padding(.horizontal, themeManager.layout.standardSpace)
            }
        }
    }
}

private extension NewReleasesView {
    var newReleaseText: some View {
        return Text(language("Home_A_04"))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}
