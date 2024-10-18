//
//  PlayerManager.swift
//  RhythmRise
//
//  Created by dtrognn on 13/10/24.
//

import AVKit
import Combine
import Foundation
import RRCore

final class PlayerManager: NSObject, ObservableObject {
    static var shared = PlayerManager()

    @Published var currentMedia: MediaItemViewData? {
        didSet {
            onUpdateMedia.send(())
            isShowMiniPlayer = true
            play(currentMedia?.previewUrl ?? "")
        }
    }

    @Published var isShowMiniPlayer: Bool = false

    var minTime: TimeInterval = 0.0
    var realDuration: TimeInterval = 30.0
    var onUpdateMedia = PassthroughSubject<Void, Never>()
    var onUpdateCurrentTime = PassthroughSubject<TimeInterval, Never>()
    var onUpdatePlayingState = PassthroughSubject<Bool, Never>()

    private var player: AVAudioPlayer?
    private var tracksQueue: [MediaItemViewData] = []
    private var timer: Timer.TimerPublisher?
    private var cancellableSet: Set<AnyCancellable> = []
    private var duration: TimeInterval = 0.0
    private var currentTime: TimeInterval = .init(0)
    private var isPlaying: Bool = false

    private let numberOfSecondInMinute: Double = 60
    private let numberOfSecondInHour: Double = 60 * 60

    override init() {
        super.init()
        configureAudioSession()
    }

    func getPlayingState() -> Bool {
        return player?.isPlaying ?? false
    }

    func toggleState() {
        if player?.isPlaying == true {
            pause()
        } else {
            player?.play()
            updatePlayingState(true)
        }
    }

    func pause() {
        player?.pause()
        updatePlayingState(false)
    }

    func stop() {
        player?.stop()
        player = nil
        updatePlayingState(false)
    }

    func play(_ audioUrl: String) {
        guard let url = URL(string: audioUrl) else {
            return
        }

        if isPlaying {
            stop()
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }

            if let error = error {
                self.printMessage("Error loading audio: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                self.printMessage("No data received")
                return
            }

            do {
                player = try AVAudioPlayer(data: data)
                player?.delegate = self
                player?.prepareToPlay()

                DispatchQueue.main.async {
                    self.player?.play()
                    self.startTimer()
                    self.updatePlayingState(true)
                }
            } catch {
                self.printMessage("Error playing audio: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            printMessage("Error setting up audio session: \(error.localizedDescription)")
        }
    }

    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 1, on: .main, in: .default)
        timer?.autoconnect().sink { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            let roundedCurrentTime = round(player.currentTime * 10) / 10.0
            self.onUpdateCurrentTime.send(roundedCurrentTime)

            if roundedCurrentTime == 0 {
                self.stop()
            }
        }.store(in: &cancellableSet)
    }

    private func stopTimer() {
        currentTime = 0
        timer?.autoconnect().upstream.connect().cancel()
    }

    private func printMessage(_ message: String) {
        #if DEBUG
            print("PLAYER MANAGER => \(message)")
        #endif
    }
}

extension PlayerManager {
    private func updatePlayingState(_ isPlaying: Bool) {
        self.isPlaying = isPlaying
        onUpdatePlayingState.send(self.isPlaying)
    }

    func getFormatDuration() -> String {
        return formatTime(with: realDuration)
    }

    func formatTime(with duration: Double) -> String {
        let durs = (duration < 1000) ? duration : (duration / 1000)
        let hrs = Int(durs) / 3600
        let mins = Int(durs) / 60 % 60
        let secs = Int(durs) % 60

        switch duration {
        case 0 ..< numberOfSecondInMinute:
            return String(format: "00:%02d", secs)
        case numberOfSecondInMinute ..< numberOfSecondInHour:
            return String(format: "%02d:%02d", mins, secs)
        default:
            return String(format: "%02d:%02d:%02d", hrs, mins, secs)
        }
    }
}

extension PlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updatePlayingState(flag)
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: (any Error)?) {
        stopTimer()
        updatePlayingState(false)
    }
}
