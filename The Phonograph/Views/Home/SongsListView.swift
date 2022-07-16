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

    // MARK: - Body
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            
            LazyHStack(spacing: 23) {
                
                ForEach(songs) { song in
                    
                    Button(action: { toPlayerScreen(song) }) {
                        CDInCaseView(song: song, scale: 0.5)
                    }
                    .buttonStyle(ScaleStyle())
                    
                } //: ForEach
                
            } //: LazyHStack
            .padding(.horizontal, Dimensions.HorizontalPadding)
            
        } //: ScrollView
        .frame(height: 150)
    }
}

// MARK: - Preview
struct SongsListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView(
            songs: TestData.songs,
            toPlayerScreen: { _ in }
        
        )
            .background(Colors.background.color)
            .previewLayout(.sizeThatFits)

    }
}
