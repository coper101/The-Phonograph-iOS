//
//  Song.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import Foundation

struct Song: Codable, Identifiable, Equatable {
    var id: String
    var title: String
    var singer: String
    var albumArtName: String
    var rankNumber: Int
    var lastPosDiff: Int
    var duration: Int // in seconds
    var releasedDate: Date
    var lyrics: String
    
    static func == (lhs: Song, rhs: Song) -> Bool {
       return lhs.id == rhs.id
   }
    
    var titleAndSingerFormat: String {
        "\(title) - \(singer)".uppercased()
    }
    
    var splitLyrics: [String] {
        lyrics.components(separatedBy: .newlines)
    }
}
