//
//  TopCDView.swift
//  The Phonograph
//
//  Created by Wind Versi on 13/7/22.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct BlurModifier: ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                color
                    .blur(radius: 100)
            )
    }
}

extension View {
    
    func backgroundBlur(color: Colors = .primary) -> some View {
        self.modifier(BlurModifier(color: color.color))
    }
    
}

struct TopCDView: View {
    // MARK: - Properties
    @State var xOffsetCD: CGFloat = .zero
    var song: Song
    
    let width: CGFloat = 132
    var xOffset: CGFloat {
        width / 2.1
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
                        
            // Layer 1:
            Group {
                CDView(
                    imageName: song.albumArtName,
                    scale: 0.5
                )
            }
                .offset(x: xOffsetCD)
                .fillMaxHeight()
            
            // Layer 2:
            VStack(spacing: 0) {}
            .fillMaxHeight()
                .frame(width: width)
                .background(
                    Colors.primary.color
                        .blur(radius: 20)
                        .scaleEffect(1.5)
                )
                .opacity(0.1)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Layer 3:
            VStack(spacing: 0) {
                
                Text("\(song.rankNumber)")
                    .textStyle(size: 65)
                    .opacity(0.1)
                    .padding(.leading, 22)
                
                Spacer()
                
                Text("\(song.lastPosDiff > 0 ? "+" : "") \(song.lastPosDiff)")
                    .textStyle(size: 18)
                    .opacity(0.1)
                    .padding(.leading, 22)
                    .padding(.bottom, 12)

                
            } //: VStack
            
        } //: VStack
        .frame(
            width: width + xOffset,
            height: 141,
            alignment: .leading
        )
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                xOffsetCD = xOffset
            }
        }
    }
}

// MARK: - Preview
struct TopCDView_Previews: PreviewProvider {
    static var previews: some View {
        TopCDView(
            song: TestData.songs[0]
        )
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
    }
}
