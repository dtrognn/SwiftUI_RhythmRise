//
//  ShowsEpisodeItemView.swift
//  RhythmRise
//
//  Created by dtrognn on 20/10/24.
//

import RRCommon
import SwiftUI

struct ShowsEpisodeConfiguration {
    var epidode: MediaItemViewData
    var onSaved: ((MediaItemViewData) -> Void)?
    var onPlay: ((MediaItemViewData) -> Void)?
}

struct ShowsEpisodeItemView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    private var configuration: ShowsEpisodeConfiguration

    init(_ configuration: ShowsEpisodeConfiguration) {
        self.configuration = configuration
    }

    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.layout.zero) {
            VStack(alignment: .leading, spacing: themeManager.layout.zero) {
                HStack(spacing: themeManager.layout.standardSpace) {
                    imageView
                    titleText
                }
                descriptionText
                    .padding(.top, themeManager.layout.mediumSpace)

                HStack(spacing: themeManager.layout.smallSpace) {
                    timeFormat()
                    getTime()
                }.padding(.top, themeManager.layout.mediumSpace)

                HStack(spacing: themeManager.layout.largeSpace) {
                    addButton
                    downloadButton
                    shareButton
                    Spacer()
                    playPauseButton
                }.padding(.top, themeManager.layout.standardSpace)
            }.padding(.top, themeManager.layout.mediumSpace)
                .padding(.bottom, themeManager.layout.standardSpace)
            StraightLineView()
        }
    }
}

private extension ShowsEpisodeItemView {
    var imageView: some View {
        return ImageUrl(configuration: .init(urlString: configuration.epidode.imageUrl)) {
            ProgressView().applyTheme()
        }.frame(width: 40, height: 40)
            .cornerRadius(themeManager.layout.standardCornerRadius)
    }

    var titleText: some View {
        return Text(configuration.epidode.name)
            .font(themeManager.font.medium16)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }

    var descriptionText: some View {
        return Text(configuration.epidode.description ?? "")
            .font(themeManager.font.regular14)
            .foregroundStyle(themeManager.theme.textNoteColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }

    var addButton: some View {
        return Button {
            configuration.onSaved?(configuration.epidode)
        } label: {
            Image(systemName: "plus.circle")
                .applyTheme(themeManager.theme.textNoteColor)
                .scaleEffect(1.1)
                .frame(height: 20)
        }
    }

    var downloadButton: some View {
        return Button {} label: {
            Image(systemName: "arrow.down.circle")
                .applyTheme(themeManager.theme.textNoteColor)
                .scaleEffect(1.1)
                .frame(height: 20)
        }
    }

    var shareButton: some View {
        return Button {} label: {
            Image(systemName: "square.and.arrow.up")
                .applyTheme(themeManager.theme.textNoteColor)
                .frame(height: 20)
        }
    }

    var playPauseButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "play.circle.fill")
                .applyTheme(.white)
                .scaleEffect(1.5)
        }
    }

    func timeFormat() -> some View {
        guard let episode = configuration.epidode.player as? EpisodeItemViewData else {
            return EmptyView().asAnyView
        }

        return Text(episode.releaseDate.formatTime(.yearMonthDay2))
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .asAnyView
    }

    func getTime() -> some View {
        guard let episode = configuration.epidode.player as? EpisodeItemViewData else {
            return EmptyView().asAnyView
        }

        return Text(String(format: "• %@", UtilsHelpers.formatTimeForEpisode(from: episode.durationMs)))
            .font(themeManager.font.regular12)
            .foregroundStyle(themeManager.theme.textNormalColor)
            .asAnyView
    }
}
