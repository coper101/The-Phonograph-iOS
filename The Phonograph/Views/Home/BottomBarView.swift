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
    @Binding var playerYOffset: CGFloat
    @Binding var playerHeightTranslation: CGFloat
    @Binding var playerIsOnDrag: Bool
    @State var titleXOffset: CGFloat = .zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                playerIsOnDrag = true
                let newTranslationHeight = value.translation.height
                var amountChange = newTranslationHeight - playerHeightTranslation
                
                // change initial amount higher than the bottom bar height
                if playerHeightTranslation == .zero {
                    amountChange -= EdgeInsets().insets.bottom + Dimensions.BottomBarHeight
                }
                
                //  print("DragGesture playerYOffset: ", playerYOffset)
                let newYOffset = playerYOffset + amountChange
                playerYOffset = newYOffset
                // print("new playerYOffset: ", playerYOffset)
                playerHeightTranslation = newTranslationHeight
            }
            .onEnded { _ in
                // reset
                playerHeightTranslation = .zero
                playerIsOnDrag = false
            }
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // MARK: Layer 1:
            VisualEffectView(effect: UIBlurEffect(style: .dark))
            
            // MARK: Layer 2:
            HStack(alignment: .top, spacing: 17) {
                
                // Col 1:
                CDView(
                    imageName: songPlaying.albumArtName,
                    scale: 0.4,
                    isPlaying: true // always playing when bottom bar is visible
                )
                    .frame(height: Dimensions.TopBarHeight * 0.8)
                    .offset(y: (Dimensions.BottomBarHeight) * 0.45)
                    .clipped()
                
                // Col 2:
                VStack(alignment: .leading, spacing: 2) {
                    
                    // Row 1:
                    SongMarqueeTextView(
                        titleAndSinger: songPlaying.titleAndSingerFormat,
                        leftPadding: .zero
                    )

                    // Row 2:
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
        .frame(height: Dimensions.BottomBarHeight + EdgeInsets().insets.bottom)
        .clipShape(Rectangle())
        .gesture(drag)
    }
}

// MARK: - Preview
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(
            songPlaying: TestData.songs[3],
            time: "0:49",
            playerYOffset: .constant(.zero),
            playerHeightTranslation: .constant(.zero),
            playerIsOnDrag: .constant(false)
        )
            .previewLayout(.sizeThatFits)
    }
}
