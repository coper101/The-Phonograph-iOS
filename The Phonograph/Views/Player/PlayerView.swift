//
//  PlayerView.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import SwiftUI

struct PlayerView: View {
    // MARK: - Properties
    @EnvironmentObject var appState: AppState
    var song: Song
    
    var realPlayStatus: PlayStatus {
        // check this song is playing on background
        guard
            let songPlaying = appState.songPlaying,
            appState.selectedSong == songPlaying
        else {
            return .paused
        }
        return appState.playStatus
    }

    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: - Row 1: Top Bar
            ZStack(alignment: .center) {
                
                // Layer 1:
                VStack(alignment: .center, spacing: 4) {
                    
                    // Row 1:
                    Text("NOW PLAYING")
                        .textStyle(size: 15)
                        .opacity(0.5)
                    
                    // Row 2:
                    Text("\(song.title) - \(song.singer)".uppercased())
                        .textStyle(size: 15, lineLimit: 1)
                    
                } //: VStack
                .padding(.horizontal, 48 + 15)
                              
                // Layer 2:
                Button(action: appState.backToHomeScreen) {
                                        
                    Icons.minimize.image
                        .resizable()
                        .scaledToFit()
                        .padding(14)
                        .frame(width: 48, height: 48)
                        .foregroundColor(Colors.primary.color.opacity(0.4))
                        .fillMaxWidth(alignment: .trailing)
                        .padding(.horizontal, Dimensions.HorizontalPadding / 2)
                    
                }
                
            } //: HStack
            .fillMaxWidth()
            .frame(height: 54)
            
            Spacer()
            
            // MARK: - Row 2: CD Player
            CDInCaseView(
                song: song,
                isOnList: false,
                time: Int(appState.elapseTime).toMinSecTimeFormat(),
                isPlaying: realPlayStatus == .playing
            )
            
            Spacer()
            
            // MARK: - Row 3: Lyrics
            ScrollView {
                VStack(spacing: 12) {
                    
                    Text("You turn me on like a light switch")
                        .textStyle(size: 15)
                        .opacity(0.5)
                    
                    Text("When you're movin' your body around and around")
                        .textStyle(size: 18)
                        .opacity(0.9)
                    
                    Text("You got me in a tight grip (yeah)")
                        .textStyle(size: 15)
                        .opacity(0.5)

                } //: VStack
                .multilineTextAlignment(.center)
            }
            .frame(height: 110)
            
            Spacer()
            
            // MARK: - Row 4: Play Button
            PlayOrPauseButtonView(
                playStatus: realPlayStatus,
                scale: 1,
                isOnPlayer: true,
                action: appState.playOrPauseSong
            )
            
            Spacer()
            
            // MARK: - Row 5: Model
            Text("Playing on Model 1900")
                .textStyle(size: 14)
                .opacity(0.3)
                .padding(.bottom, 21)
            
                        
        } //: VStack
        .fillMaxSize()
    }
}

// MARK: - Preview
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(song: TestData.songs[0])
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
            .environmentObject(AppState())
    }
}
