//
//  PlayerView.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import RRCommon
import SwiftUI

struct PlayerView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject private var playerManager: PlayerManager
    @Binding private var isPresent: Bool

    @State private var currentTime: TimeInterval = 0
    @State private var isPlaying: Bool = false

    init(_ isPresent: Binding<Bool>) {
        self._isPresent = isPresent
    }

    private var screenConfiguration: ScreenConfiguration {
        return .init(
            title: playerManager.currentMedia?.name ?? "",
            showBackButton: false,
            hidesBottomBarWhenPushed: true,
            showNaviUnderline: false,
            showNaviBar: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: themeManager.layout.standardSpace) {
                    trackImageView.padding(.top, themeManager.layout.largeSpace)

                    VStack(alignment: .leading, spacing: themeManager.layout.smallSpace) {
                        mediaNameText
                        artistsText
                    }

                    playerView()
                }.padding(.horizontal, themeManager.layout.largeSpace)
            }
        }.overlay(dismissButton, alignment: .topLeading)
            .onAppear {
                playerManager.play(playerManager.currentMedia?.previewUrl ?? "")
            }.onReceive(playerManager.onUpdateCurrentTime) { currentTime in
                self.currentTime = currentTime
            }.onReceive(playerManager.onUpdatePlayingState) { isPlaying in
                self.isPlaying = isPlaying
            }
    }
}

private extension PlayerView {
    @ViewBuilder func playerView() -> some View {
        VStack(spacing: themeManager.layout.zero) {
            VStack(spacing: themeManager.layout.zero) {
                sliderView
                timeView
            }

            HStack(spacing: themeManager.layout.standardSpace) {
                Spacer()
                backwardButton
                Spacer()
                playPauseButton
                Spacer()
                forwardButton
                Spacer()
            }.padding(.vertical, themeManager.layout.largeSpace)
        }
    }

    var sliderView: some View {
        return Slider(
            value: $currentTime,
            in: playerManager.minTime ... playerManager.realDuration,
            onEditingChanged: { _ in

            }).tint(.white)
            .onAppear {
                let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
                UISlider.appearance()
                    .setThumbImage(UIImage(systemName: "circle.fill",
                                           withConfiguration: progressCircleConfig), for: .normal)
            }
    }

    var timeView: some View {
        return HStack {
            currentTimeText
            Spacer()
            durationText
        }
    }

    var playPauseButton: some View {
        return Button {
            playerManager.toggleState()
        } label: {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .applyTheme(.white)
                .scaleEffect(3)
        }
    }

    var backwardButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "backward.end.fill")
                .applyTheme(.white)
                .scaleEffect(2)
        }
    }

    var forwardButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "forward.end.fill")
                .applyTheme(.white)
                .scaleEffect(2)
        }
    }

    var currentTimeText: some View {
        return Text(playerManager.formatTime(with: currentTime))
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.whiteTextColor)
    }

    var durationText: some View {
        return Text(playerManager.getFormatDuration())
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.whiteTextColor)
    }
}

private extension PlayerView {
    var dismissButton: some View {
        return Button {
            withAnimation { isPresent = false }
        } label: {
            Image(systemName: "chevron.down")
                .applyTheme(.white)
                .scaleEffect(1.2)
                .frame(width: 22, height: 22)
                .padding(.leading, themeManager.layout.largeSpace)
                .padding(.top, 18)
        }
    }

    var trackImageView: some View {
        return ImageUrl(configuration: .init(urlString: playerManager.currentMedia?.imageUrl ?? "")) {
            ProgressView().applyTheme()
        }.cornerRadius(themeManager.layout.standardCornerRadius)
            .aspectRatio(1, contentMode: .fill)
    }

    var mediaNameText: some View {
        return Marquee {
            HStack {
                Text(playerManager.currentMedia?.name ?? "")
                    .font(themeManager.font.semibold24)
                    .foregroundStyle(themeManager.theme.textNormalColor)
            }
        }.marqueeDuration(20)
            .marqueeAutoreverses(true)
            .marqueeDirection(.right2left)
            .marqueeWhenNotFit(true)
            .marqueeIdleAlignment(.leading)
            .frame(height: 30)
    }

    var artistsText: some View {
        return Text(playerManager.getArtistsFormat())
            .font(themeManager.font.regular16)
            .foregroundStyle(themeManager.theme.textNoteColor)
    }
}
