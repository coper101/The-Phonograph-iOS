//
//  TopSongsListView.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import SwiftUI

struct TopSongsListView: View {
    // MARK: - Properties
    var songs: [Song]
    var toPlayerScreen: (Song) -> Void

    // MARK: - Body
    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            
            LazyHStack(spacing: 10) {
                
                ForEach(songs) { song in
                    
                    Button(action: { toPlayerScreen(song) } ) {
                        TopCDView(song: song)
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
struct TopSongsListView_Previews: PreviewProvider {
    static var previews: some View {
        TopSongsListView(
            songs: TestData.songs,
            toPlayerScreen: { _ in }
        )
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
    }
}

struct ScaleStyle: ButtonStyle {
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .opacity(isPressed ? 0.5 : 1.0)
            .onChange(of: configuration.isPressed) {
                isPressed = $0
            }
    }
}

