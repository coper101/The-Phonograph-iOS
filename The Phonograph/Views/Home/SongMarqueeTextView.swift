//
//  SongMarqueeTextView.swift
//  The Phonograph
//
//  Created by Wind Versi on 23/7/22.
//

import SwiftUI

struct SongMarqueeTextView: View {
    // MARK: - Properties
    var titleAndSinger: String
    var leftPadding: CGFloat = 45

    // MARK: - Body
    var body: some View {
        if titleAndSinger.count * 12 > 500 {
            LinearGradient(
                colors: [
                    Colors.primary.color.opacity(leftPadding == .zero ? 1 : 0.05),
                    Colors.primary.color.opacity(leftPadding == .zero ? 1 : 0.9),
                    Colors.primary.color,
                    Colors.primary.color.opacity(0.9),
                    Colors.primary.color.opacity(0.05)
                ],
                startPoint: .leading,
                endPoint: .trailing
            ).mask {
                MarqueeTextView(text: titleAndSinger)
                    .padding(.leading, leftPadding)
            }
            .frame(height: 20)
        } else {
            Text(titleAndSinger)
                .textStyle(
                    size: 15,
                    lineLimit: 1
                )
        }
    }
}

// MARK: - Preview
struct SongMarqueeTextView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            SongMarqueeTextView(
                titleAndSinger: TestData.songs[3].titleAndSingerFormat
            )
            SongMarqueeTextView(
                titleAndSinger: TestData.songs[0].titleAndSingerFormat
            )
        }
        .padding()
        .background(Colors.background.color)
        .previewLayout(.sizeThatFits)
    }
}
