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
                    VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                        allEpisodesView.padding(.leading, themeManager.layout.standardSpace)
                        episodesListView
                    }.padding(.top, themeManager.layout.standardSpace)
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

                VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                    showNameText
                    publisherText
                }.frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack(spacing: themeManager.layout.largeSpace) {
                followButton
                settingButton
                notifyButton
                moreButton
            }.padding(.vertical, themeManager.layout.largeSpace)

            descriptionText
        }.padding(.horizontal, themeManager.layout.standardSpace)
    }

    var episodesListView: some View {
        return LazyVStack(spacing: themeManager.layout.zero) {
            ForEach(vm.episodes) { episode in
                ShowsEpisodeItemView(.init(epidode: episode))
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

    var descriptionText: some View {
        return Text(vm.show?.description ?? "----")
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .lineSpacing(themeManager.layout.lineSpacing)
            .multilineTextAlignment(.leading)
    }

    var followButton: some View {
        return Button {
            // TODO: -
        } label: {
            Text(language("Common_A_01"))
                .font(themeManager.font.regular16)
                .foregroundStyle(themeManager.theme.textNormalColor)
                .padding(.vertical, themeManager.layout.mediumSpace)
                .padding(.horizontal, themeManager.layout.standardSpace)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(themeManager.theme.textNormalColor, lineWidth: 1)
                )
        }
    }

    var settingButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image.image("ic_setting")
                .applyTheme(.white)
                .scaleEffect(1.2)
        }
    }

    var notifyButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image.image("ic_notify")
                .applyTheme(.white)
                .scaleEffect(1.2)
        }
    }

    var moreButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(.white)
        }
    }

    var allEpisodesView: some View {
        return HStack(spacing: themeManager.layout.standardSpace) {
            Image(systemName: "slider.horizontal.3")
                .applyTheme(.white)

            Text(language("Show_Detail_A_01"))
                .font(themeManager.font.medium16)
                .foregroundStyle(themeManager.theme.textNormalColor)
        }
    }
}
