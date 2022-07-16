//
//  PlayOrPauseButtonView.swift
//  The Phonograph
//
//  Created by Wind Versi on 13/7/22.
//

import SwiftUI

enum PlayStatus: String, CaseIterable, Identifiable {
    case playing, paused
    var id: String {
        self.rawValue
    }
}

struct PlayOrPauseButtonView: View {
    // MARK: - Properties
    var playStatus: PlayStatus
    var scale: CGFloat = 1
    var isOnPlayer = false
    
    var length: CGFloat {
        isOnPlayer ? 83 : scale * 39
    }
    
    var cornerRadius: CGFloat {
        isOnPlayer ? 21 : scale * 10
    }
    
    var action: () -> Void = {}
    
    var icon: Icons {
        playStatus == .playing ? .pause : .play
    }

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: length, height: length)
                .overlay(
                    icon.image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.4)
                        .foregroundColor(Colors.primary.color)
                )
                .foregroundColor(Colors.primary.color.opacity(0.05))
            
        } //: Button
    }
}

// MARK: - Preview
struct PlayOrPauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ForEach(PlayStatus.allCases) { status in
                PlayOrPauseButtonView(playStatus: status)
                    .previewDisplayName(status.rawValue)
            }
            
            ForEach(PlayStatus.allCases) { status in
                PlayOrPauseButtonView(
                    playStatus: status,
                    isOnPlayer: true
                )
                    .previewDisplayName("\(status.rawValue) on Player")
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Colors.background.color)

    }
}
