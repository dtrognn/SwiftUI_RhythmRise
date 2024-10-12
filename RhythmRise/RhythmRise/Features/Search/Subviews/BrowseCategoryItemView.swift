//
//  BrowseCategoryItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 12/10/24.
//

import RRCommon
import SwiftUI

struct BrowseCategoryItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var browseCategory: BrowseCategoryItemViewData
    private var onSelect: (BrowseCategoryItemViewData) -> Void

    init(_ browseCategory: BrowseCategoryItemViewData, onSelect: @escaping (BrowseCategoryItemViewData) -> Void) {
        self.browseCategory = browseCategory
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onSelect(browseCategory)
        } label: {
            VStack {
                VStack(spacing: themeManager.layout.zero) {
                    HStack {
                        Spacer()
                        imageView
                    }.padding(.top, themeManager.layout.largeSpace)
                }.overlay(titleText, alignment: .topLeading)
            }
            .background(Color.random)
            .cornerRadius(themeManager.layout.standardCornerRadius)
        }
    }
}

private extension BrowseCategoryItemView {
    var titleText: some View {
        return Text(browseCategory.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textWhiteColor)
            .padding([.leading, .vertical], themeManager.layout.standardSpace)
    }

    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: browseCategory.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 60, height: 60)
            .cornerRadius(themeManager.layout.standardCornerRadius)
            .rotationEffect(.degrees(25))
            .offset(x: 15)
            .frame(maxHeight: .infinity, alignment: .bottomTrailing)
    }
}
