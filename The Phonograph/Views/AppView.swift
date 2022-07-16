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
    @StateObject var songModelData: SongModelData = .init()
    @StateObject var appState: AppState = .init()

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer 1: HOME SCREEN
            HomeView()
                .background(Colors.background.color)
                .zIndex(0)
            
            // Layer 2: PLAYER SCREEN
            if appState.selectedScreen == .player,
               let song = appState.selectedSong {
                
                PlayerView(song: song)
                    .background(Colors.background.color)
                    .zIndex(1)
                
            }
        } //: ZStack
        .environmentObject(songModelData)
        .environmentObject(appState)

    }
}

// MARK: - Preview
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
