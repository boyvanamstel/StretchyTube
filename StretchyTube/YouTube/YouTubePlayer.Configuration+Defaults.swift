//
//  YouTubePlayer.Configuration+Defaults.swift
//  StretchyTube
//
//  Created by Boy van Amstel on 01/12/2022.
//  Copyright © 2022 Danger Cove. All rights reserved.
//

import Foundation
import YouTubePlayerKit

extension YouTubePlayer.Configuration {
    static var standard = Self.init(autoPlay: true, playInline: true)
}
