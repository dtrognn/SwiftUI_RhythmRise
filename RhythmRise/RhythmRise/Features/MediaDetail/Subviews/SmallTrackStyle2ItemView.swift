//
//  SmallTrackStyle2ItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 15/10/24.
//

import RRCommon
import SwiftUI

struct SmallTrackStyle2ItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var track: TrackItemViewData
    private var onSelect: ((TrackItemViewData) -> Void)?
    private var onSelectOption: ((TrackItemViewData) -> Void)?

    init(_ track: TrackItemViewData, onSelect: ((TrackItemViewData) -> Void)? = nil, onSelectOption: ((TrackItemViewData) -> Void)? = nil) {
        self.track = track
        self.onSelect = onSelect
        self.onSelectOption = onSelectOption
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(track)
        } label: {
            HStack(spacing: themeManager.layout.mediumSpace) {
                VStack(alignment: .leading, spacing: themeManager.layout.smallSpace) {
                    titleText
                    descriptionText
                }
                Spacer()
                moreButton
            }
        }
    }
}

private extension SmallTrackStyle2ItemView {
    var titleText: some View {
        return Text(track.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var descriptionText: some View {
        return Text(track.artists.map { $0.name }.joined(separator: ", "))
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineLimit(2)
    }

    var moreButton: some View {
        return Button {
            onSelectOption?(track)
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(.white)
        }
    }
}
