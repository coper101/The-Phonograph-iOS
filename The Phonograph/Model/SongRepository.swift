//
//  SongRepository.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import Foundation

protocol SongRepositoryProtocol {
    var songs: [Song] { get set }
    var songsPublished: Published<[Song]> { get }
    var songsPublisher: Published<[Song]>.Publisher { get }
    
    func loadSongs() -> Void
}

class SongRepository: ObservableObject, SongRepositoryProtocol {
    
    @Published var songs: [Song] = []
    var songsPublished: Published<[Song]> { _songs }
    var songsPublisher: Published<[Song]>.Publisher { $songs }
    
    init() {
        loadSongs()
    }
    
    func loadSongs() {
        songs = Utils.loadData("Songs")
    }

}
