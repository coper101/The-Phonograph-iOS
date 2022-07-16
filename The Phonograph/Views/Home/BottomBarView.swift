//
//  BottomBarView.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import SwiftUI

struct BottomBarView: View {
    // MARK: - Properties
    var songPlaying: Song
    var time: String

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // MARK: Layer 1:
            VisualEffectView(effect: UIBlurEffect(style: .dark))
            
            // MARK: Layer 2:
            HStack(alignment: .top, spacing: 17) {
                
                // Col 1:
                CDView(scale: 0.4)
                    .frame(height: Dimensions.TopBarHeight * 0.8)
                    .offset(y: (Dimensions.BottomBarHeight) * 0.45)
                    .clipped()
                
                // Col 2:
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Row 1:
                    Text(
                        "\(songPlaying.title) - \(songPlaying.singer)".uppercased()
                    )
                        .textStyle(size: 15, lineLimit: 1)
                    
                    // Row 3:
                    HStack(spacing: 0) {
                        
                        // Col 1:
                        Text("NOW PLAYING")
                            .textStyle(size: 15)
                            .opacity(0.5)
                        
                        // Col 2:
                        
                        Spacer()
                        
                        // Col 3: TIME PLAYED
                        Text(time)
                            .textStyle(size: 15)
                        
                    } //: HStack
                    
                } //: VStack
                .padding(.top, 15)
                .fillMaxHeight(alignment: .top)
                
            } //: HStack
            .padding(.trailing, Dimensions.HorizontalPadding)
            .padding(.leading, Dimensions.HorizontalPadding / 2)
            
        } //: ZStack
        .fillMaxWidth(alignment: .leading)
        .frame(height: Dimensions.BottomBarHeight + 30)
        .clipShape(Rectangle())
    }
}

// MARK: - Preview
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(
            songPlaying: TestData.songs[0],
            time: "0:49"
        )
            .previewLayout(.sizeThatFits)
    }
}
