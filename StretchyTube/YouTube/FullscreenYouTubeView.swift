//
//  FullscreenYouTubeView.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 01/12/2022.
//  Copyright © 2022 Danger Cove. All rights reserved.
//

import SwiftUI
import YouTubePlayerKit

struct FullscreenYouTubeView: View {
    private let player: YouTubePlayer
    private let viewModel: YouTubeViewModel

    @Binding
    private var isFullscreen: Bool

    init(isFullscreen: Binding<Bool>, viewModel: YouTubeViewModel) {
        self.player = YouTubePlayer(source: .video(id: viewModel.videoId, startSeconds: viewModel.currentSeconds),
                                    configuration: .standard)

        self._isFullscreen = isFullscreen
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black
                .ignoresSafeArea(.all)
            YouTubePlayerView(player)
            ZStack {
                Button(action: {}, label: { Color.black.opacity(0.01) })
                    .disabled(true) // Prevent touch through
                Button(action: {
                    Task { @MainActor in
                        viewModel.seek(to: (try? await player.getCurrentTime()) ?? 0)
                        
                        player.pause()
                        
                        isFullscreen = false
                    }
                }, label: {
                    Color.clear
                })
            }.frame(width: 50, height: 35)
        }
    }
}
