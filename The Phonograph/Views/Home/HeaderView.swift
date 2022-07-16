//
//  HeaderView.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    var title: String

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            // Col 1:
            Text(title)
                .textStyle(size: 19)
            
            // Col 2:
            Spacer()
            
        } //: HStack
        .padding(.horizontal, Dimensions.HorizontalPadding)
    }
}

// MARK: - Preview
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Top 10")
            .background(Colors.background.color)
            .previewLayout(.sizeThatFits)
    }
}
