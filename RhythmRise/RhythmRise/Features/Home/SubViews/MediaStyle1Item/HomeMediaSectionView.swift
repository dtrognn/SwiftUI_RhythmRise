//
//  HomeMediaSectionView.swift
//  RhythmRise
//
//  Created by dtrognn on 15/10/24.
//

import RRCommon
import SwiftUI

struct HomeMediaSectionConfiguration {
    var title: String
    var medias: [MediaItemViewData]
    var itemSize: CGFloat
    var itemAlignment: HorizontalAlignment
    var itemShape: any Shape
    var itemImageContentMode: ImageContentMode
    var onSelect: ((MediaItemViewData) -> Void)?

    init(title: String,
         medias: [MediaItemViewData],
         itemSize: CGFloat,
         itemAlignment: HorizontalAlignment = .leading,
         itemShape: any Shape,
         itemImageContentMode: ImageContentMode = .fit,
         onSelect: ((MediaItemViewData) -> Void)? = nil)
    {
        self.title = title
        self.medias = medias
        self.itemSize = itemSize
        self.itemAlignment = itemAlignment
        self.itemShape = itemShape
        self.itemImageContentMode = itemImageContentMode
        self.onSelect = onSelect
    }
}

struct HomeMediaSectionView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var configuration: HomeMediaSectionConfiguration

    init(_ configuration: HomeMediaSectionConfiguration) {
        self.configuration = configuration
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            titleSectionText.padding(.horizontal, themeManager.layout.standardSpace)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: themeManager.layout.standardSpace) {
                    ForEach(configuration.medias) { media in
                        MediaStyle1ItemView(.init(
                            media: media,
                            size: configuration.itemSize,
                            alignment: configuration.itemAlignment,
                            clipShape: configuration.itemShape,
                            imageContentMode: configuration.itemImageContentMode,
                            onSelect: { mediaSelected in
                                configuration.onSelect?(mediaSelected)
                            }))
                    }
                }.padding(.horizontal, themeManager.layout.standardSpace)
            }
        }
    }
}

private extension HomeMediaSectionView {
    var titleSectionText: some View {
        return Text(configuration.title)
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}
