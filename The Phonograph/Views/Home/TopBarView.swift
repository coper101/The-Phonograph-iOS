//
//  TopBarView.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

struct TopBarView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            // MARK: Col 1:
            VStack(alignment: .leading, spacing: 2) {
                
                // Row 1: APP NAME
                Text("The Phonograph")
                    .textStyle(size: 24)
                
                // Row 2:
                HStack(spacing: 15) {
                    
                    Group {
                        Text("Played 201")
                        Text("Model 1900")
                    }
                    .textStyle(size: 14)
                    .opacity(0.5)
                    
                } //: HStack
                
            } //: VStack
            
            // MARK: Col 2
            Spacer()
            
            // MARK: Col 3: PROFILE IMAGE
            Button(action: {}) {
                
                Circle()
                    .fill(Colors.primary.color.opacity(0.2))
                    .frame(width: 37, height: 37)
                    .overlay(
                        Icons.profileImagePlaceholder.image
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                            .foregroundColor(Colors.primary.color.opacity(0.6))
                            .offset(y: 5)
                    )
                    .clipShape(Circle())
                
            } //: Button
            
        } //: HStack
        .padding(.horizontal, Dimensions.HorizontalPadding)
        .frame(height: Dimensions.TopBarHeight)
        .background(
            LinearGradient(
                colors: [
                    Colors.background.color,
                    Colors.background.color.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Preview
struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
            .previewLayout(.sizeThatFits)
    }
}
