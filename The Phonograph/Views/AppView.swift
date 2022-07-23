//
//  AppView.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

enum Screen {
    case home
    case player
}

struct AppView: View {
    // MARK: - Properties
    @StateObject var appState: AppViewModel = .init()

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer 1: HOME SCREEN
            HomeView()
                .background(Colors.background.color)
                .zIndex(0)
            
            // Layer 2: PLAYER SCREEN
            // appState.selectedScreen == .player
            if let song = appState.selectedSong {
                
                PlayerView(song: song)
                    .background(Colors.background.color)
                    .zIndex(1)
                    // .transition(.move())
                    .offset(y: appState.playerYOffset)
                    .animation(.interactiveSpring(), value: appState.playerYOffset)
            }
            
        } //: ZStack
        .environmentObject(appState)
        .ignoresSafeArea(.container, edges: .bottom)
        .onChange(of: appState.selectedSong) { song in
            guard let _ = song, !appState.playerIsOnDrag else { return }
            // MIN: show player screen
            appState.playerYOffset = .zero
        }
        .onChange(of: appState.playerIsOnDrag) { isDragging in
            guard isDragging else {
                // snap to full screen if it reaches half of screen
                if appState.playerYOffset < Dimensions.Screen.height / 2 {
                    appState.playerYOffset = .zero
                } else {
                    appState.playerYOffset = Dimensions.Screen.height
                }
                // hide if it reaches more than that half
                return
            }
            // shows player screen
            appState.selectedSong = appState.songPlaying
        }
    }
}

// MARK: - Preview
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
