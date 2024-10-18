//
//  MiniPlayerView.swift
//  RhythmRise
//
//  Created by dtrognn on 16/10/24.
//

import Combine
import RRCommon
import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var playerManager: PlayerManager
    @StateObject private var vm = MiniPlayerVM()

    private var onSelect: (() -> Void)?

    @State private var backgroundColor: Color = .clear
    @State private var isPlaying: Bool = false
    private let IMAGE_SIZE: CGFloat = 35

    init(_ onSelect: (() -> Void)? = nil) {
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            onSelect?()
        } label: {
            VStack(spacing: themeManager.layout.zero) {
                HStack(spacing: themeManager.layout.mediumSpace) {
                    HStack(spacing: themeManager.layout.mediumSpace) {
                        mediaImage
                        VStack(alignment: .leading, spacing: themeManager.layout.smallSpace) {
                            titleText
                            artistsText
                        }
                    }
                    Spacer()
                    playPauseButton.padding(.trailing, themeManager.layout.mediumSpace)
                }.padding(.all, themeManager.layout.mediumSpace)
            }.background(vm.backgroundColor)
                .cornerRadius(themeManager.layout.standardCornerRadius)
                .padding(.horizontal, themeManager.layout.mediumSpace)
                .transition(.move(edge: .top))
                .animation(.easeIn, value: playerManager.isShowMiniPlayer)
                .onReceive(playerManager.onUpdateMedia) { _ in
                    vm.getBackgroundColor(from: playerManager.currentMedia?.imageUrl ?? "")
                }.onReceive(playerManager.onUpdatePlayingState) { isPlaying in
                    self.isPlaying = isPlaying
                }
        }
    }
}

private extension MiniPlayerView {
    var mediaImage: some View {
        return ImageUrl(configuration: .init(urlString: playerManager.currentMedia?.imageUrl ?? "")) {
            ProgressView().asAnyView
        }.frame(width: IMAGE_SIZE, height: IMAGE_SIZE)
            .cornerRadius(themeManager.layout.standardCornerRadius)
    }

    var playPauseButton: some View {
        return Button {
            playerManager.toggleState()
        } label: {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .applyTheme(.white)
                .scaleEffect(1.1)
        }
    }

    var titleText: some View {
        return Marquee {
            Text(playerManager.currentMedia?.name ?? "")
                .font(themeManager.font.regular14)
                .foregroundStyle(themeManager.theme.textNormalColor)
        }.marqueeDuration(20)
            .marqueeAutoreverses(true)
            .marqueeDirection(.right2left)
            .marqueeWhenNotFit(true)
            .marqueeIdleAlignment(.leading)
            .frame(height: 15)
    }

    var artistsText: some View {
        return Text(playerManager.currentMedia?.getArtistsFormat() ?? "")
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .lineLimit(1)
    }
}
