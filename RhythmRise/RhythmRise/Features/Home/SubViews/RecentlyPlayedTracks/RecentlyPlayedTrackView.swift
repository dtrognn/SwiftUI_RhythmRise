//
//  RecentlyPlayedTrackView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct RecentlyPlayedTrackView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var recentlyPlayedTracks: [TrackItemViewData]
    private var onSelect: ((TrackItemViewData) -> Void)?
    private var onSelectShowAll: (() -> Void)?

    init(_ recentlyPlayedTracks: [TrackItemViewData],
         onSelect: ((TrackItemViewData) -> Void)? = nil,
         onSelectShowAll: (() -> Void)? = nil)
    {
        self.recentlyPlayedTracks = recentlyPlayedTracks
        self.onSelect = onSelect
        self.onSelectShowAll = onSelectShowAll
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            HStack(spacing: themeManager.layout.mediumSpace) {
                recentlyText
                Spacer()
                showAllButton
            }.padding(.horizontal, themeManager.layout.standardSpace)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: themeManager.layout.standardSpace) {
                    ForEach(recentlyPlayedTracks) { track in
                        RecentlyPlayedTrackItemView(track) { trackSelected in
                            onSelect?(trackSelected)
                        }
                    }
                }.padding(.horizontal, themeManager.layout.standardSpace)
            }
        }
    }
}

private extension RecentlyPlayedTrackView {
    var recentlyText: some View {
        return Text(language("Home_A_02"))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }

    var showAllButton: some View {
        return Button {
            onSelectShowAll?()
        } label: {
            Text(language("Home_A_03"))
                .font(themeManager.font.medium14)
                .foregroundStyle(themeManager.theme.textNoteColor)
        }
    }
}
