//
//  AppViewModel.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation
import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    
    // Timer
    private let stopwatch: Stopwatch
    private var cancellablesElapseTime: Set<AnyCancellable> = []
    @Published var elapseTime: TimeInterval = .zero
    
    // Data
    private let storage: Storage
    private let recentlyPlayedSongsfilename = "RecentlyPlayedSongs.json"
    private let trackSongsfilename = "TrackSongs.json"
    @Published var recentlyPlayedSongs: [Song] = []
    
    private let songRepository: SongRepository
    private var cancellablesSong: Set<AnyCancellable> = []
    @Published var songs: [Song] = []

    var sortByRankNum: [Song] {
        songs.sorted { $0.rankNumber > $1.rankNumber }
    }
    var sortByTitleSongs: [Song] {
        songs.sorted { $0.title > $1.title }
    }
    var sortByReleasedDate: [Song] {
        songs.sorted { $0.releasedDate > $1.releasedDate }
    }
    
    // App
    @Published var selectedScreen: Screen = .home
    @Published var selectedSong: Song? = nil
    @Published var songPlaying: Song? = nil
    @Published var playStatus: PlayStatus = .paused
    @Published var playerModel = "Model 1900"
    
    @Published var playerYOffset: CGFloat = Dimensions.Screen.height // MAX: hides player screen
    @Published var playerHeightTranslation: CGFloat = .zero
    @Published var playerIsOnDrag = false
    
    init(
        stopwatch: Stopwatch = Stopwatch(),
        storage: Storage = Storage(),
        songRepository: SongRepository = SongRepository()
    ) {
        self.stopwatch = stopwatch
        self.storage = storage
        self.songRepository = songRepository
        getSongs()
        getElapseTime()
        loadRecentlyPlayedSongs()
    }
    
    func getSongs() {
        // republish songs from SongRepository
        songRepository.$songs
            .assign(to: \.songs, on: self)
            .store(in: &cancellablesSong)
    }
    
    func getElapseTime() {
        // republish elapseTime from Stopwatch
        stopwatch.$elapseTime
            .assign(to: \.elapseTime, on: self)
            .store(in: &cancellablesElapseTime)
    }

    func backToHomeScreen() {
        selectedSong = nil
        // selectedScreen = .home
        playerYOffset = Dimensions.Screen.height
        print("playerYOffset: ", playerYOffset)
    }
    
    func toPlayerScreen(song: Song) {
        selectedSong = song
        selectedScreen = .player
    }
    
    func playSelectedSong() {
        playStatus = .playing
        guard playStatus == .playing else { return }
        
        songPlaying = selectedSong
        guard let songPlaying = songPlaying else { return }
        
        saveRecentlyPlayedSong(song: songPlaying)
        
        var theElapseTime: TimeInterval? = nil
        if let lastStoppedTime = getSongLastStoppedTime(of: songPlaying) {
            theElapseTime = TimeInterval(lastStoppedTime)
        }
        
        // start timer, continue from last stopped time
        stopwatch.startTimer(
            duration: TimeInterval(songPlaying.duration),
            lastElapsedTime: theElapseTime ?? .zero,
            onEnded: {
                DispatchQueue.main.async {
                    self.songPlaying = nil
                    self.playStatus = .paused
                    self.saveLastStoppedTime(
                        of: songPlaying,
                        with: .zero
                    )
                }
            }
        ) // stopwatch
    }
    
    func pauseSelectedSong() {
        playStatus = .paused
        guard playStatus == .paused else { return }
        
        // save the stopped time
        if let songPlaying = songPlaying {
            saveLastStoppedTime(
                of: songPlaying,
                with: Int(stopwatch.elapseTime)
            )
        }
        songPlaying = nil
        stopwatch.resetTimer()
    }
    
    func playOrPauseSong(song: Song) {
        let songPlayStatus = getSongPlayStatus(song: song)
        guard songPlayStatus == .playing else {
            playSelectedSong()
            return
        }
        pauseSelectedSong()
    }
    
    func getSongPlayStatus(song: Song) -> PlayStatus {
        guard
            let songPlaying = songPlaying,
            songPlaying == song else {
            return .paused
        }
        return .playing
    }
    
    // MARK: - Storage
    func getRecentlyPlayedSongs() -> [Song]? {
        storage.getItems(filename: recentlyPlayedSongsfilename)
    }
    
    func getTrackSongs() -> [TrackSong]? {
        storage.getItems(filename: trackSongsfilename)
    }
    
    func saveRecentlyPlayedSong(song: Song) {
        // check if song exists
        var songs = getRecentlyPlayedSongs() ?? []
        guard !songs.contains(song) else {
            return
        }
        
        // save song
        songs.append(song)
        storage.saveItems(
            filename: recentlyPlayedSongsfilename,
            items: songs
        )
        
        loadRecentlyPlayedSongs()
    }

    private func loadRecentlyPlayedSongs() {
        guard let songs = getRecentlyPlayedSongs() else { return }
        recentlyPlayedSongs = songs
    }
    
    func getSongLastStoppedTime(of song: Song) -> Int? {
        guard
            let trackSongs = getTrackSongs(),
            let trackSong = trackSongs.first(where: { $0.songId == song.id })
        else { return nil }
        return trackSong.pausedTime
    }
    
    func saveLastStoppedTime(of song: Song, with time: Int) {
        var trackSongs = getTrackSongs() ?? []
        // remove existing song
        if let currentIndex = trackSongs.firstIndex(where: { $0.songId == song.id }) {
            trackSongs.remove(at: currentIndex)
        }
        // modify or add song with paused time
        trackSongs.append(
            TrackSong(songId: song.id, pausedTime: time)
        )
        storage.saveItems(
            filename: trackSongsfilename,
            items: trackSongs
        )
    }
    
}
