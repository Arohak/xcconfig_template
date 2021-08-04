//
//  AudioPlayerProtocol.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

protocol AudioPlayerProtocol: AnyObject {
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item)
    func audioPlayer(_ player: AudioPlayer, didPausePlaybackOf item: AudioPlayer.Item)
    func audioPlayerDidStop(_ player: AudioPlayer)
}

extension AudioPlayerProtocol {
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {}
    func audioPlayer(_ player: AudioPlayer, didPausePlaybackOf item: AudioPlayer.Item) {}
    func audioPlayerDidStop(_ player: AudioPlayer) {}
}
