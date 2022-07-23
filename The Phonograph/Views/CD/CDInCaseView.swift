//
//  CDInCaseView.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import SwiftUI

struct CDInCaseView: View {
    // MARK: - Properties    
    var song: Song
    var scale: CGFloat = 1
    var isOnList = true
    var caseOpacity: CGFloat {
        isOnList ? 0.1 : 0.05
    }
    var time = "0:00"
    var isPlaying = false
    var action: () -> Void = {}

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            
            // Row 1:
            CDView(
                imageName: song.albumArtName,
                scale: scale,
                isPlaying: isPlaying,
                hasAnimation: !isOnList
            )
            
            // Row 2:
            HStack(alignment: .bottom, spacing: 0) {
                
                // Col 1: PLAY OR PAUSE BUTTON
                if isOnList {
                    PlayOrPauseButtonView(
                        playStatus: isPlaying ? .playing : .paused,
                        scale: scale,
                        action: action
                    )
                }
                
                // Col 2:
                Spacer()
                
                // Col 3: DURATION OF SONG
                Text(isPlaying ? time : "\(song.duration.toMinSecTimeFormat())")
                    .textStyle(size: Int(scale) * 15)
                    .opacity(0.5)
                    .padding(.trailing, scale * 5)
                    .alignmentGuide(.bottom) { $0.height + (scale * 5) }
                
            } //: HStack
            
        } //: VStack
        .padding(scale * 12)
        .frame(width: scale * 265)
        .background(Colors.primary.color.opacity(caseOpacity))
        .clipShape(RoundedRectangle(cornerRadius: scale * 15))
    }
}

// MARK: - Preview
struct CDInCaseView_Previews: PreviewProvider {
    static var previews: some View {
        CDInCaseView(
            song: TestData.songs[0],
            scale: 0.5
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
        
        CDInCaseView(
            song: TestData.songs[0],
            scale: 0.5,
            isOnList: false,
            isPlaying: true
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
            .previewDisplayName("Player")
    }
}
