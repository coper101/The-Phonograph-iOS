//
//  SongModelData.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import Foundation

class SongModelData: ObservableObject {
    
    @Published var songs: [Song] = []
    
    var sortByTitleSongs: [Song] {
        songs.sorted { $0.title > $1.title }
    }
    
    
    init() {
        songs = Utils.loadData("Songs")
    }
    
}
