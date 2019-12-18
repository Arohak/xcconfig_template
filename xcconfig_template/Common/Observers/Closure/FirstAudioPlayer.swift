//
//  FirstAudioPlayer.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation

class FirstAudioPlayer: AudioPlayer {
    typealias AudioPlayerItemClosure = (AudioPlayer, Item) -> Void
    typealias AudioPlayerClosure = (AudioPlayer) -> Void
    
    private var observations = (
        started: [UUID: AudioPlayerItemClosure](),
        paused: [UUID: AudioPlayerItemClosure](),
        stopped: [UUID: AudioPlayerClosure]()
    )
    
    override func stateDidChange() {
        switch state {
        case .idle:
            observations.stopped.values.forEach { closure in
                closure(self)
            }
        case .playing(let item):
            observations.started.values.forEach { closure in
                closure(self, item)
            }
        case .paused(let item):
            observations.paused.values.forEach { closure in
                closure(self, item)
            }
        }
    }
}

// MARK: - Base
extension FirstAudioPlayer {
    @discardableResult
    func observePlaybackStarted(using closure: @escaping AudioPlayerItemClosure) -> ObservationToken {
        let id = observations.started.insert(closure)

        return ObservationToken { [weak self] in
            self?.observations.started.removeValue(forKey: id)
        }
    }

    @discardableResult
    func observePlaybackPaused(using closure: @escaping AudioPlayerItemClosure) -> ObservationToken {
        let id = observations.paused.insert(closure)

        return ObservationToken { [weak self] in
            self?.observations.paused.removeValue(forKey: id)
        }
    }

    @discardableResult
    func observePlaybackStopped(using closure: @escaping (AudioPlayer) -> Void) -> ObservationToken {
        let id = observations.stopped.insert(closure)

        return ObservationToken { [weak self] in
            self?.observations.stopped.removeValue(forKey: id)
        }
    }
}

// MARK: - Advanced
extension FirstAudioPlayer {
    @discardableResult
    func addPlaybackStartedObserver<T: AnyObject>(_ observer: T, closure: @escaping (T, AudioPlayer, Item) -> Void) -> ObservationToken {
        let id = UUID()

        observations.started[id] = { [weak self, weak observer] player, item in
            // If the observer has been deallocated, we can
            // automatically remove the observation closure.
            guard let observer = observer else {
                self?.observations.started.removeValue(forKey: id)
                return
            }

            closure(observer, player, item)
        }

        return ObservationToken { [weak self] in
            self?.observations.started.removeValue(forKey: id)
        }
    }
}

