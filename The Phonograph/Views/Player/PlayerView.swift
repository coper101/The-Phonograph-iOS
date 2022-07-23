//
//  PlayerView.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import SwiftUI

struct PlayerView: View {
    // MARK: - Properties
    @EnvironmentObject var appState: AppViewModel
    var song: Song
        
    var playStatusMessage: String {
        appState.getSongPlayStatus(song: song) == .playing ?
            "Playing" : "Play"
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
                    SongMarqueeTextView(titleAndSinger: song.titleAndSingerFormat)
            
                } //: VStack
                .padding(.horizontal, 48 + 15)
                              
                // Layer 2:
                Button(action: didTapMinimize) {
                                        
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
                isPlaying: appState.getSongPlayStatus(song: song) == .playing
            )
            
            Spacer()
            
            // MARK: - Row 3: Lyrics
            ScrollView {
                VStack(spacing: 12) {
                    
                    Text(song.splitLyrics[0])
                        .textStyle(size: 15)
                        .opacity(0.5)
                    
                    Text(song.splitLyrics[1])
                        .textStyle(size: 18)
                        .opacity(0.9)
                    
                    Text(song.splitLyrics[2])
                        .textStyle(size: 15)
                        .opacity(0.5)

                } //: VStack
                .multilineTextAlignment(.center)
            }
            .frame(height: 110)
            
            Spacer()
            
            // MARK: - Row 4: Play Button
            PlayOrPauseButtonView(
                playStatus: appState.getSongPlayStatus(song: song),
                scale: 1,
                isOnPlayer: true,
                action: { appState.playOrPauseSong(song: song) }
            )
            
            Spacer()
            
            // MARK: - Row 5: Model
            Text("\(playStatusMessage) on \(appState.playerModel)")
                .textStyle(size: 14)
                .opacity(0.3)
                .id(playStatusMessage + appState.playerModel)
                .transition(.opacity.animation(.easeIn(duration: 0.3)))
                .padding(.bottom, EdgeInsets().insets.top)
                        
        } //: VStack
        .fillMaxSize()
    }
    
    // MARK: - Functions
    func didTapMinimize() {
        withAnimation(.spring()) {
            appState.backToHomeScreen()
        }
    }
}

// MARK: - Preview
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(song: TestData.songs[0])
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
            .environmentObject(AppViewModel())
    }
}
