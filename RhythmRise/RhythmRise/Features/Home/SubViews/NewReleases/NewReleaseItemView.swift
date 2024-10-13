//
//  NewReleaseItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct NewReleaseItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var album: AlbumItemViewData
    private var onSelect: ((AlbumItemViewData) -> Void)?

    private let WIDTH: CGFloat = 130

    init(_ album: AlbumItemViewData, onSelect: ((AlbumItemViewData) -> Void)? = nil) {
        self.album = album
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect?(album)
        } label: {
            VStack(spacing: themeManager.layout.mediumSpace) {
                imageView
                titleText
            }.frame(maxWidth: WIDTH)
        }
    }
}

private extension NewReleaseItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: album.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: WIDTH, height: WIDTH)
    }

    var titleText: some View {
        return Text(album.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .frame(height: 40, alignment: .topLeading)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
