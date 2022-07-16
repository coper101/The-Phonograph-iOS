//
//  HomeView.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @EnvironmentObject var songModelData: SongModelData
    @EnvironmentObject var appState: AppState
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            // MARK: Layer 1: Content
            ScrollView {
                
                VStack(spacing: 25) {
                    
                    // Row 2: TOP 10
                    VStack(spacing: 15) {
                        HeaderView(title: "Top 10")
                        TopSongsListView(
                            songs: songModelData.songs,
                            toPlayerScreen: appState.toPlayerScreen
                        )
                    }
                    
                    // Row 3: RECENTLY PLAYED
                    VStack(spacing: 15) {
                        HeaderView(title: "Recently Played")
                        SongsListView(
                            songs: songModelData.sortByTitleSongs,
                            toPlayerScreen: appState.toPlayerScreen
                        )
                    }
                    
                    // Row 4: LATEST RELEASE
                    VStack(spacing: 15) {
                        HeaderView(title: "Latest Release")
                        SongsListView(
                            songs: songModelData.sortByTitleSongs,
                            toPlayerScreen: appState.toPlayerScreen
                        )
                    }
                    
                } //: VStack
                .padding(.top, Dimensions.TopBarHeight + 10)
                
            } //: ScrollView
            
            // MARK: Layer 2:
            VStack {
                
                // Row 1: TOP BAR
                TopBarView()
                
                // Row 2:
                Spacer()
                
                // Row 3: BOTTOM BAR PREVIEW
                if let songPlaying = appState.songPlaying {
                    Button(
                        action: { appState.toPlayerScreen(song: songPlaying) }
                    ) {
                        BottomBarView(
                            songPlaying: songPlaying,
                            time: Int(appState.elapseTime).toMinSecTimeFormat()
                        )
                    }
                }
                
            } //: VStack
             
        } //: ZStack
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
            .environmentObject(SongModelData())
            .environmentObject(AppState())
    }
}
