//
//  AudioPlayer.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

class AudioPlayer {
    typealias Item = String

    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }

    var state = State.idle {
        didSet {
            stateDidChange()
        }
    }

    func stateDidChange() {}
}
