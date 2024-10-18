//
//  LibraryView.swift
//  RhythmRise
//
//  Created by dtrognn on 10/10/24.
//

import RRCommon
import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm = LibraryVM()

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", hidesBottomBarWhenPushed: false, showNaviBar: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
                VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
                    headerView
                    mediaTypesView
                }

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        savedList
                    }.padding(.bottom, 3 * themeManager.layout.standardButtonHeight)
                }
            }.padding(.all, themeManager.layout.standardSpace)
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension LibraryView {
    var headerView: some View {
        return HStack(spacing: themeManager.layout.mediumSpace) {
            HStack(spacing: themeManager.layout.standardSpace) {
                avatarImage
                libraryText
            }
            Spacer()
            HStack(spacing: themeManager.layout.largeSpace) {
                searchButton
                addButton
            }
        }
    }

    var avatarImage: some View {
        return ImageUrl(configuration: .init(urlString: AppDataManager.shared.userContext.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 35, height: 35)
            .clipShape(.circle)
    }

    var searchButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image.image("ic_tabbar_search")
                .applyTheme(.white)
                .scaleEffect(1.3)
        }
    }

    var addButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "plus")
                .applyTheme(.white)
                .scaleEffect(1.5)
        }
    }

    var libraryText: some View {
        return Text(language("Library_A_01"))
            .font(themeManager.font.medium24)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }
}

private extension LibraryView {
    var mediaTypesView: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: themeManager.layout.standardSpace) {
                ForEach(vm.mediaTypes, id: \.self) { type in
                    Button {
                        // TODO: -
                    } label: {
                        Text(language(type.title))
                            .font(themeManager.font.regular14)
                            .foregroundStyle(themeManager.theme.textNormalColor)
                            .padding(.vertical, themeManager.layout.mediumSpace)
                            .padding(.horizontal, themeManager.layout.standardSpace)
                            .background(themeManager.theme.iconOffColor)
                            .cornerRadius(themeManager.layout.standardSpace)
                    }
                }
            }
        }.fixedSize(horizontal: false, vertical: true)
    }

    var savedList: some View {
        return LazyVStack(spacing: themeManager.layout.standardSpace) {
            ForEach(vm.recents) { media in
                LibraryMediaItemView(media)
            }
        }
    }
}
