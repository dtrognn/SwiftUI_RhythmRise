//
//  MediaStyle1ItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 15/10/24.
//

import RRCommon
import SwiftUI

struct MediaStyle1Configuration {
    var media: MediaItemViewData
    var size: CGFloat
    var clipShape: any Shape
    var onSelect: ((MediaItemViewData) -> Void)?

    init(media: MediaItemViewData,
         size: CGFloat,
         clipShape: any Shape = .rect,
         onSelect: ((MediaItemViewData) -> Void)? = nil)
    {
        self.media = media
        self.size = size
        self.clipShape = clipShape
        self.onSelect = onSelect
    }
}

struct MediaStyle1ItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var configuration: MediaStyle1Configuration

    init(_ configuration: MediaStyle1Configuration) {
        self.configuration = configuration
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            configuration.onSelect?(configuration.media)
        } label: {
            VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                imageView
                titleText
            }.frame(maxWidth: configuration.size)
        }
    }
}

private extension MediaStyle1ItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: configuration.media.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: configuration.size, height: configuration.size)
            .clipShape(configuration.clipShape)
            .asAnyView
    }

    var titleText: some View {
        return Text(configuration.media.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .frame(height: 40, alignment: .topLeading)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}
