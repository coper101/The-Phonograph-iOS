//
//  SongsListView.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import SwiftUI

struct SongsListView: View {
    // MARK: - Properties
    var songs: [Song]
    var toPlayerScreen: (Song) -> Void
    var songPlaying: Song?
    var songElapseTime: Int = .zero

    // MARK: - Body
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            
            LazyHStack(spacing: 23) {
                
                ForEach(songs) { song in
                                        
                    Button(action: { didTapSong(song) }) {
                        CDInCaseView(
                            song: song,
                            scale: 0.5,
                            time: songPlaying != nil ? songElapseTime.toMinSecTimeFormat() : "0:00",
                            isPlaying: isPlaying(song: song)
                        )
                    }
                    .buttonStyle(ScaleStyle())
                    
                } //: ForEach
                
            } //: LazyHStack
            .padding(.horizontal, Dimensions.HorizontalPadding)
            
        } //: ScrollView
        .frame(height: 150)
    }
    
    // MARK: - Functions
    func isPlaying(song: Song) -> Bool {
        guard let songPlaying = songPlaying else {
            return false
        }
        return songPlaying == song
    }
    
    // MARK: - Functions
    func didTapSong(_ song: Song) {
        withAnimation(.spring()) {
            toPlayerScreen(song)
        }
    }
}

// MARK: - Preview
struct SongsListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView(
            songs: TestData.songs,
            toPlayerScreen: { _ in },
            songPlaying: TestData.songs[0]
        
        )
            .background(Colors.background.color)
            .previewLayout(.sizeThatFits)

    }
}
