//
//  YouTubeView.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 29/11/2022.
//

import SwiftUI
import YouTubePlayerKit

struct YouTubeView: View {
    private let player: YouTubePlayer
    private let viewModel: YouTubeViewModel

    @State
    private var isFullscreen = false

    init(viewModel: YouTubeViewModel) {
        self.viewModel = viewModel
        self.player = YouTubePlayer(source: .video(id: viewModel.videoId,
                                                   startSeconds: viewModel.startSeconds,
                                                   endSeconds: viewModel.endSeconds),
                                    configuration: .standard)
    }

    var body: some View {
        GeometryReader { g in
            VStack(alignment: .center) {
                ZStack(alignment: .bottomTrailing) {
                    YouTubePlayerView(player)
                        .fullScreenCover(
                            isPresented: $isFullscreen,
                            onDismiss: {
                                player.seek(to: Double(viewModel.currentSeconds ?? 0), allowSeekAhead: true)

                                player.play()
                            }, content: {
                                FullscreenYouTubeView(isFullscreen: $isFullscreen,
                                                      viewModel: viewModel)
                            })
                    ZStack {
                        Button(action: {}, label: { Color.black.opacity(0.01) })
                            .disabled(true) // Prevent touch through
                        Button(action: {
                            Task { @MainActor in
                                viewModel.seek(to: (try? await player.getCurrentTime()) ?? 0)

                                player.pause()

                                isFullscreen = true
                            }
                        }, label: {
                            Color.clear
                        })
                    }.frame(width: 50, height: 35)
                }.frame(height: g.size.width / 16 * 9)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeView(viewModel: YouTubeViewModel(videoId: "q5D55G7Ejs8"))
    }
}
