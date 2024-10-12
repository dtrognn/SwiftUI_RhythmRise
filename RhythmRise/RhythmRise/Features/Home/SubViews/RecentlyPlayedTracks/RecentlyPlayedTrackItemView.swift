//
//  RecentlyPlayedTrackItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct RecentlyPlayedTrackItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var track: TrackItemViewData
    private var onSelect: (TrackItemViewData) -> Void

    private let WIDTH: CGFloat = 120

    init(_ track: TrackItemViewData, onSelect: @escaping (TrackItemViewData) -> Void) {
        self.track = track
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect(track)
        } label: {
            VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                imageView
                titleText
            }.frame(maxWidth: WIDTH)
        }
    }
}

private extension RecentlyPlayedTrackItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: track.album.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: WIDTH, height: WIDTH)
    }

    var titleText: some View {
        return Text(track.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
