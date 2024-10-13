//
//  RecommendationsView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct RecommendationsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var recommendations: [TrackItemViewData]
    private var onSelect: ((TrackItemViewData) -> Void)?

    init(_ recommendations: [TrackItemViewData], onSelect: ((TrackItemViewData) -> Void)? = nil) {
        self.recommendations = recommendations
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            forUserText.padding(.horizontal, themeManager.layout.standardSpace)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: themeManager.layout.standardSpace) {
                    ForEach(recommendations) { track in
                        HomeTrackItemView(track) { trackSelected in
                            onSelect?(trackSelected)
                        }
                    }
                }.padding(.horizontal, themeManager.layout.standardSpace)
            }
        }
    }
}

private extension RecommendationsView {
    var forUserText: some View {
        return Text(String(format: language("Home_A_05"), AppDataManager.shared.userContext.displayName))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}
