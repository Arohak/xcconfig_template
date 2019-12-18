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
    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }
    
    typealias Item = String
    typealias AudioPlayerItemClosure = (AudioPlayer, Item) -> Void
    typealias AudioPlayerClosure = (AudioPlayer) -> Void

    var state = State.idle {
        didSet { stateDidChange() }
    }


    func stateDidChange() {}
}
