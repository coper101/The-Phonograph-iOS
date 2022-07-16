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
            duration: 120
        ),
        .init(
            id: "2",
            title: "Love Dive",
            singer: "Ive",
            albumArtName: "LoveDive",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120
        ),
        .init(
            id: "3",
            title: "Left and Right",
            singer: "Charlie Puth feat Jungkook",
            albumArtName: "LeftAndRight",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120
        ),
        .init(
            id: "4",
            title: "As It Was",
            singer: "Harry Styles",
            albumArtName: "AsItWas",
            rankNumber: 1,
            lastPosDiff: 2,
            duration: 120
        )
    ]
}
