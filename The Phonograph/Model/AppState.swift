//
//  AppState.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    
    @Published var selectedScreen: Screen = .home
    @Published var selectedSong: Song? = nil
    @Published var songPlaying: Song? = nil
    @Published var playStatus: PlayStatus = .paused
        
    private var stopwatch: Stopwatch = Stopwatch()
    
    @Published var elapseTime: TimeInterval = .zero
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // republish elapseTime from Stopwatch
        stopwatch.$elapseTime
            .assign(to: \.elapseTime, on: self)
            .store(in: &cancellables)
    }

    func backToHomeScreen() {
        selectedSong = nil
        selectedScreen = .home
    }
    
    func toPlayerScreen(song: Song) {
        selectedSong = song
        selectedScreen = .player
    }
    
    func playOrPauseSong() {
        playStatus = (playStatus == .playing) ? .paused : .playing
        
        if playStatus == .playing {
            songPlaying = selectedSong
            
            guard let songPlaying = songPlaying else {
                return
            }
            stopwatch.startTimer(duration: TimeInterval(songPlaying.duration))
            
        } else {
            songPlaying = nil
        }
        songPlaying = (playStatus == .playing) ? selectedSong : nil
    }
    
    
    
}
