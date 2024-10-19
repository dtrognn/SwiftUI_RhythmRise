//
//  ShowDetailView.swift
//  RhythmRise
//
//  Created by dtrognn on 19/10/24.
//

import RRCommon
import SwiftUI

struct ShowDetailView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm: ShowDetailVM

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", showBackButton: true, showNaviUnderline: false, showNaviBar: true)
    }

    init(_ id: String) {
        self._vm = StateObject(wrappedValue: ShowDetailVM(id))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: themeManager.layout.zero) {
                    showInfoView
                }.padding(.vertical, themeManager.layout.standardSpace)
            }
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension ShowDetailView {
    var showInfoView: some View {
        return VStack(alignment: .leading, spacing: themeManager.layout.zero) {
            HStack(spacing: themeManager.layout.standardSpace) {
                showImage

                VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
                    showNameText
                    publisherText
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }.padding(.horizontal, themeManager.layout.standardSpace)
    }

    var showImage: some View {
        return ImageUrl(configuration: .init(urlString: vm.show?.imageUrl ?? "")) {
            ProgressView().applyTheme()
        }.frame(width: 100, height: 100)
            .cornerRadius(themeManager.layout.standardCornerRadius)
    }

    var showNameText: some View {
        return Text(vm.show?.name ?? "")
            .font(themeManager.font.medium20)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }

    var publisherText: some View {
        return Text(vm.show?.getArtistsFormat() ?? "")
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}
