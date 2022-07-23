//
//  MarqueeTextView.swift
//  The Phonograph
//
//  Created by Wind Versi on 19/7/22.
//

import SwiftUI

struct MarqueeTextView: View {
    // MARK: - Properties
    @State private var mainTextXOffset: CGFloat = .zero
    var text: String
    
    var maxTextWidth: CGFloat {
        CGFloat(text.count * 12)
    }
    
    var xOffset: CGFloat {
        maxTextWidth + mainTextXOffset
    }
    
    // MARK: - Body
    var body: some View {
        // geometry reader has max width of screen width
        GeometryReader { reader in
            ZStack {
                Text(text)
                    .offset(x: mainTextXOffset)
                    .frame(width: maxTextWidth, alignment: .leading) // this will force the width to expand
                     // .background(Color.blue)
                    Text(text)
                        .frame(width: maxTextWidth, alignment: .leading)
                         // .background(Color.red)
                        .offset(x: xOffset)
            }
            .textStyle(
                size: 15,
                lineLimit: 1
            )
        }
        .frame(height: 20)
        .onAppear {
            withAnimation(
                .linear(duration: 8.0)
                .delay(1.0)
                .repeatForever(autoreverses: false)
            ) {
                mainTextXOffset = -maxTextWidth
            }
        }
    }
}

// MARK: - Preview
struct MarqueeTextView_Previews: PreviewProvider {
    static var previews: some View {
        MarqueeTextView(text: "Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title Title")
            .previewLayout(.sizeThatFits)
            .background(Colors.background.color)
    }
}
