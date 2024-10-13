//
//  ArtistDetailView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct ArtistDetailView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject private var vm: ArtistDetailVM

    private var coordinatorNameSpace = "SCROLL"

    private var screenConfiguration: ScreenConfiguration {
        return .init(title: "", showNaviBar: false)
    }

    init(_ artistId: String) {
        self._vm = StateObject(wrappedValue: ArtistDetailVM(artistId))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            GeometryReader { containerProxy in
                let safeArea = containerProxy.safeAreaInsets
                let size = containerProxy.size

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: themeManager.layout.standardSpace) {
                        artistImageView(safeArea: safeArea, size: size)
                        VStack(spacing: themeManager.layout.largeSpace) {
                            tracksView
                            albumsView
                        }.padding(.bottom, themeManager.layout.standardButtonHeight * 3)
                            .background(themeManager.theme.backgroundColor)
                            .zIndex(1)
                    }.overlay(alignment: .top) {
                        headerView(safeArea: safeArea, size: size)
                    }
                }.coordinateSpace(name: coordinatorNameSpace)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }.onAppear {
            vm.loadData()
        }
    }
}

private extension ArtistDetailView {
    @ViewBuilder
    func artistImageView(safeArea: EdgeInsets, size: CGSize) -> some View {
        let height = size.height * 0.45

        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named(coordinatorNameSpace)).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

            ImageUrl(configuration: .init(urlString: vm.artist?.imageLargeUrl ?? ""), contentMode: .fill) {
                ProgressView().applyTheme()
            }.frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom) {
                        blur(progress)

                        artistInfoView()
                            .opacity(1 + (progress > 0 ? -progress : progress))
                            .padding(.bottom, themeManager.layout.standardSpace)
                            .offset(y: minY < 0 ? minY : 0)
                    }
                }.offset(y: -minY)
        }.frame(height: height + safeArea.top)
    }

    func blur(_ progress: Double) -> some View {
        Rectangle()
            .fill(
                .linearGradient(colors: [
                    .black.opacity(0 - progress),
                    .black.opacity(0.1 - progress),
                    .black.opacity(0.3 - progress),
                    .black.opacity(0.5 - progress),
                    .black.opacity(0.8 - progress),
                    .black.opacity(1),
                ], startPoint: .top, endPoint: .bottom)
            )
    }

    func artistInfoView() -> some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            artistNameText
            VStack(alignment: .leading, spacing: themeManager.layout.mediumSpace) {
                followersView
                HStack(spacing: themeManager.layout.largeSpace) {
                    followButton
                    optionButton
                    Spacer()
                    playButton
                }.padding(.trailing, themeManager.layout.standardSpace)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, themeManager.layout.standardSpace)
    }

    var artistNameText: some View {
        return Text(vm.artist?.name ?? "")
            .font(themeManager.font.semibold30)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }

    var followersView: some View {
        return HStack(spacing: themeManager.layout.smallSpace) {
            ForEach(vm.artist?.genres ?? [], id: \.self) { genre in
                Text(genre)
                    .font(themeManager.font.regular12)
                    .foregroundStyle(themeManager.theme.textNoteColor)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(themeManager.theme.textNoteColor, lineWidth: 1)
                    )
            }
        }
    }

    var followButton: some View {
        return Button {
            // TODO: -
        } label: {
            Text(language("Common_A_01"))
                .font(themeManager.font.medium16)
                .foregroundStyle(themeManager.theme.textNormalColor)
                .padding(.vertical, themeManager.layout.mediumSpace)
                .padding(.horizontal, themeManager.layout.standardSpace)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(themeManager.theme.textNoteColor, lineWidth: 1)
                )
        }
    }

    var optionButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "ellipsis")
                .applyTheme(themeManager.theme.textNoteColor)
        }
    }

    var playButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image.image("ic_play_arrow")
                .applyTheme(.black)
                .scaleEffect(1.3)
                .padding(.all, themeManager.layout.mediumSpace)
                .background(
                    Circle().fill(Color.green)
                )
        }
    }
}

private extension ArtistDetailView {
    @ViewBuilder
    func headerView(safeArea: EdgeInsets, size: CGSize) -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named(coordinatorNameSpace)).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height

            HStack(spacing: themeManager.layout.zero) {
                backButton
                Spacer()
            }.padding(.horizontal, themeManager.layout.standardSpace)
                .overlay {
                    Text(vm.artist?.name ?? "")
                        .font(themeManager.font.semibold16)
                        .foregroundStyle(themeManager.theme.naviTextColor)
                        .offset(y: -titleProgress > 0.75 ? 0 : 45)
                        .clipped()
                        .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
                }
                .padding(.top, safeArea.top + 10)
                .padding([.bottom], themeManager.layout.standardSpace)
                .background(
                    themeManager.theme.naviBackgroundColor
                        .opacity(-progress > 1 ? 1 : 0)
                ).offset(y: -minY)
        }.frame(height: 35)
    }

    var backButton: some View {
        return Button {
            router.pop()
        } label: {
            Image(systemName: "chevron.backward")
                .applyTheme(themeManager.theme.naviBackIconColor)
                .frame(width: 22, height: 22)
        }
    }
}

private extension ArtistDetailView {
    var tracksView: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            tracksPopularText
            LazyVStack(spacing: themeManager.layout.standardSpace) {
                ForEach(Array(vm.topTracks.enumerated()), id: \.0) { index, track in
                    SmallTrackItemView(index: index + 1, track: track)
                }
            }
        }.padding(.horizontal, themeManager.layout.standardSpace)
    }

    var tracksPopularText: some View {
        return Text(language("Artist_Detail_A_02"))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }

    var albumsView: some View {
        return VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
            HStack {
                releasesText
                Spacer()
                showAllButton
            }
            LazyVStack(spacing: themeManager.layout.standardSpace) {
                ForEach(vm.albums) { album in
                    ArtistDetailAlbumItemView(album)
                }
            }
        }.padding(.horizontal, themeManager.layout.standardSpace)
    }

    var releasesText: some View {
        return Text(language("Artist_Detail_A_03"))
            .font(themeManager.font.semibold18)
            .foregroundStyle(themeManager.theme.textNormalColor)
    }

    var showAllButton: some View {
        return Button {
            // TODO: -
        } label: {
            Text(language("Common_A_02"))
                .font(themeManager.font.medium16)
                .foregroundStyle(themeManager.theme.textNoteColor)
        }
    }
}
