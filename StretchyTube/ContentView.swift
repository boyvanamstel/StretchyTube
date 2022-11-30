//
//  ContentView.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 29/11/2022.
//

import SwiftUI
import YouTubePlayerKit

class PlayerState: ObservableObject {
    var startTime: Double
    var captionLanguage: String?

    init(startTime: Double) {
        self.startTime = startTime
    }
}

struct FullscreenContentView: View {
    private let player = YouTubePlayer(source: .video(id: "i4GJnpOZmiM"),
                                       configuration: .init(autoPlay: true))

    @Binding
    var isFullscreen: Bool

    @Binding
    var playerState: PlayerState

    var body: some View {
        ZStack {
            YouTubePlayerView(player)
                .edgesIgnoringSafeArea(.all)
                .onAppear() {
                    player.seek(to: playerState.startTime, allowSeekAhead: true)
                }
            Button("Dismiss") {
                Task { @MainActor in
                    playerState.startTime = (try? await player.getCurrentTime()) ?? 0
                    let metaData = try? await player.getVideoURL()

                    player.pause()

                    isFullscreen = false
                }
            }
        }
    }
}

struct ContentView: View {
    private let player = YouTubePlayer(source: .video(id: "i4GJnpOZmiM"),
                                       configuration: .init(autoPlay: true))

    @State
    private var isFullscreen = false

    @State
    private var playerState: PlayerState = PlayerState(startTime: 0)

    var body: some View {
        VStack {
            YouTubePlayerView(player)
                .fullScreenCover(
                    isPresented: $isFullscreen,
                    onDismiss: {
                        player.seek(to: playerState.startTime, allowSeekAhead: true)
                        player.play()
                    }, content: {
                        FullscreenContentView(isFullscreen: $isFullscreen,
                                              playerState: $playerState)
                    })
            Button("Fullscreen") {
                Task { @MainActor in
                    playerState.startTime = (try? await player.getCurrentTime()) ?? 0
                    playerState.captionLanguage = player.configuration.captionLanguage

                    player.pause()

                    isFullscreen = true
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
