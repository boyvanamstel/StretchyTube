//
//  StretchyTubeApp.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 29/11/2022.
//

import SwiftUI

@main
struct StretchyTubeApp: App {
    var body: some Scene {
        WindowGroup {
            YouTubeView(viewModel: YouTubeViewModel(videoId: "q5D55G7Ejs8"))
        }
    }
}
