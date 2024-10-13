//
//  SmallTrackItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct SmallTrackItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var index: Int
    private var track: TrackItemViewData
    private var onSelect: ((TrackItemViewData) -> Void)?
    private var onSelectOption: ((TrackItemViewData) -> Void)?

    init(index: Int,
         track: TrackItemViewData,
         onSelect: ((TrackItemViewData) -> Void)? = nil,
         onSelectOption: ((TrackItemViewData) -> Void)? = nil)
    {
        self.index = index
        self.track = track
        self.onSelect = onSelect
        self.onSelectOption = onSelectOption
    }

    var body: some View {
        HStack(alignment: .center, spacing: themeManager.layout.mediumSpace) {
            HStack(spacing: themeManager.layout.standardSpace) {
                indexText
                imageView
                VStack(alignment: .leading, spacing: themeManager.layout.smallSpace) {
                    trackNameText
                    descriptionText
                }
            }
            Spacer()
            moreButton
        }
    }
}

private extension SmallTrackItemView {
    var indexText: some View {
        return Text("\(index)")
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(width: 15)
    }

    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: track.album.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 50, height: 50)
    }

    var trackNameText: some View {
        return Text(track.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var moreButton: some View {
        return Button {
            onSelectOption?(track)
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(.white)
        }
    }

    var descriptionText: some View {
        return Text(track.artists.map { $0.name }.joined(separator: ", "))
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
