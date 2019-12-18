//
//  ObserversViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 12/18/19.
//  Copyright © 2019 Ara Hakobyan. All rights reserved.
//

import Foundation
import UIKit

class ObserversViewController: UIViewController {
    enum Style {
        case closure
        case protocole
    }
    
    private var style: Style = .closure
    private var observationToken: ObservationToken?
    private let firstPlayer = FirstAudioPlayer()
    private let secondPlayer = SecondAudioPlayer()

    deinit {
        observationToken?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testPlayer()
    }
    
    private func testPlayer() {
        switch style {
        case .closure:
            print("**** Closure ****")
            addFirstPlayerObservers()
            changeFirstPlayerState()
        case .protocole:
            print("**** Protocol **** ")
            addSecondPlayerObservers()
            changeSecondPlayerState()
        }
    }
}

// MARK: - Closure Case
extension ObserversViewController {
    private func addFirstPlayerObservers() {
        observationToken = firstPlayer.observePlaybackPaused { player, item in
            print("item: \(item)")
            print("Playback_Paused")
        }
        
        firstPlayer.addPlaybackStartedObserver(self) { vc, player, item in
            print("item: \(item)")
            print("Playback_Started")
        }
    }
    
    private func changeFirstPlayerState() {
        (0...3).forEach { i in
            let state: AudioPlayer.State = i % 2 == 0 ? .playing("Play") : .paused("Pause")
            firstPlayer.state = state
        }
    }
}

// MARK: - Protocol Case
extension ObserversViewController {
    private func addSecondPlayerObservers() {
        secondPlayer.addObserver(self)
    }
    
    private func changeSecondPlayerState() {
        (0...3).forEach { i in
            let state: AudioPlayer.State = i % 2 == 0 ? .playing("Play") : .paused("Pause")
            secondPlayer.state = state
        }
    }
}

extension ObserversViewController: AudioPlayerProtocol {
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {
        print("item: \(item)")
        print("Playback_Started")
    }
    
    func audioPlayer(_ player: AudioPlayer, didPausePlaybackOf item: AudioPlayer.Item) {
        print("item: \(item)")
        print("Playback_Paused")
    }
}
