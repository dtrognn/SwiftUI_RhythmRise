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
    var alignment: HorizontalAlignment
    var clipShape: any Shape
    var imageContentMode: ImageContentMode
    var onSelect: ((MediaItemViewData) -> Void)?

    init(media: MediaItemViewData,
         size: CGFloat,
         alignment: HorizontalAlignment = .leading,
         clipShape: any Shape = .rect,
         imageContentMode: ImageContentMode = .fit,
         onSelect: ((MediaItemViewData) -> Void)? = nil)
    {
        self.media = media
        self.size = size
        self.alignment = alignment
        self.clipShape = clipShape
        self.imageContentMode = imageContentMode
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
            VStack(alignment: configuration.alignment, spacing: themeManager.layout.mediumSpace) {
                imageView
                titleText
            }.frame(maxWidth: configuration.size)
        }
    }
}

private extension MediaStyle1ItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: configuration.media.imageUrl), contentMode: configuration.imageContentMode) {
            ProgressView().applyTheme()
        }.frame(width: configuration.size, height: configuration.size)
            .clipShape(configuration.clipShape)
            .asAnyView
    }

    var titleText: some View {
        return Text(configuration.media.name)
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(height: 40, alignment: .topLeading)
            .lineLimit(2)
            .multilineTextAlignment(configuration.alignment == .leading ? .leading : .center)
    }
}
