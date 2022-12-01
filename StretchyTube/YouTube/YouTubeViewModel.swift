//
//  YouTubeViewModel.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 01/12/2022.
//  Copyright © 2022 Danger Cove. All rights reserved.
//

import Foundation

class YouTubeViewModel {
    let videoId: String
    let startSeconds: Int
    let endSeconds: Int?
    private(set) var currentSeconds: Int?

    init(videoId: String, startSeconds: Int = 0, endSeconds: Int? = nil) {
        self.videoId = videoId
        self.startSeconds = startSeconds
        self.endSeconds = endSeconds
    }

    func seek(to seconds: Int) {
        currentSeconds = seconds
    }

    func seek(to seconds: Double) {
        currentSeconds = Int(seconds)
    }
}
