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
    private var media: MediaItemViewData
    private var onSelect: ((MediaItemViewData) -> Void)?
    private var onSelectOption: ((MediaItemViewData) -> Void)?

    init(_ media: MediaItemViewData, onSelect: ((MediaItemViewData) -> Void)? = nil, onSelectOption: ((MediaItemViewData) -> Void)? = nil) {
        self.media = media
        self.onSelect = onSelect
        self.onSelectOption = onSelectOption
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(media)
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
    }

    var moreButton: some View {
        return Button {
            onSelectOption?(media)
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(.white)
        }
    }
}
