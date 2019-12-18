//
//  SecondAudioPlayer.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

class SecondAudioPlayer: AudioPlayer {
    struct Observation {
        weak var observer: AudioPlayerProtocol?
    }
    
    private var observations = [ObjectIdentifier : Observation]()

    override func stateDidChange() {
        for (id, observation) in observations {
            // If the observer is no longer in memory, we
            // can clean up the observation for its ID
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }

            switch state {
            case .idle:
                observer.audioPlayerDidStop(self)
            case .playing(let item):
                observer.audioPlayer(self, didStartPlaying: item)
            case .paused(let item):
                observer.audioPlayer(self, didPausePlaybackOf: item)
            }
        }
    }
}

extension SecondAudioPlayer {
    func addObserver(_ observer: AudioPlayerProtocol) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }

    func removeObserver(_ observer: AudioPlayerProtocol) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}

