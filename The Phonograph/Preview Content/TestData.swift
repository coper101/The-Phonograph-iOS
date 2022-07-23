//
//  TestData.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation

struct TestData {
    static let songs: [Song] = [
        .init(
            id: "1",
            title: "Tomboy",
            singer: "idle",
            albumArtName: "INeverDie",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120,
            releasedDate: Date(),
            lyrics: "line1\nline2\n"
        ),
        .init(
            id: "2",
            title: "Love Dive",
            singer: "Ive",
            albumArtName: "LoveDive",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120,
            releasedDate: Date(),
            lyrics: "line1\nline2\n"
        ),
        .init(
            id: "3",
            title: "Left and Right",
            singer: "Charlie Puth feat Jungkook",
            albumArtName: "LeftAndRight",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120,
            releasedDate: Date(),
            lyrics: "line1\nline2\n"
        ),
        .init(
            id: "4",
            title: "Example Example Example Example Example Example",
            singer: "Singer",
            albumArtName: "AsItWas",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120,
            releasedDate: Date(),
            lyrics: "line1\nline2\n"
        )
    ]
}
