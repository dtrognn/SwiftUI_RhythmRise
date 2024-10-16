//
//  SmallTrackStyle1ItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct SmallTrackStyle1ItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var index: Int
    private var media: MediaItemViewData
    private var onSelect: ((MediaItemViewData) -> Void)?
    private var onSelectOption: ((MediaItemViewData) -> Void)?

    init(index: Int,
         media: MediaItemViewData,
         onSelect: ((MediaItemViewData) -> Void)? = nil,
         onSelectOption: ((MediaItemViewData) -> Void)? = nil)
    {
        self.index = index
        self.media = media
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

private extension SmallTrackStyle1ItemView {
    var indexText: some View {
        return Text("\(index)")
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(width: 15)
    }

    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: media.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 50, height: 50)
    }

    var trackNameText: some View {
        return Text(media.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }

    var moreButton: some View {
        return Button {
            onSelectOption?(media)
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(.white)
        }
    }

    var descriptionText: some View {
        if let track = media.player as? TrackItemViewData {
            let artists = track.artists.map { $0.name }.joined(separator: ", ")
            return Text(artists)
                .font(themeManager.font.regular14)
                .foregroundStyle(themeManager.theme.textNoteColor)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .asAnyView
        }

        return EmptyView().asAnyView
    }
}
