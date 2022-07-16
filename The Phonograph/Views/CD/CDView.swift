//
//  CDView.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

struct CDView: View {
    // MARK: - Properties
    var imageName: String? = nil
    var scale: CGFloat = 1
    var hasLinearOpacity = false

    // MARK: - Body
    var body: some View {
        ZStack {
            
            DonutShapeView(
                holeLength: scale * 24.82,
                fullLength: scale * 38.72
            )
            
            DonutShapeView(
                holeLength: scale * 41.45,
                fullLength: scale * 66.96
            )
            
            if let name = imageName {
                Image(name)
                    .resizable()
                    .frame(width: scale * 220, height: scale * 220)
                    .mask {
                        DonutShapeView(
                            holeLength: scale * 74,
                            fullLength: scale * 220,
                            opacity: 1.0
                        )
                    }
            } else {
                DonutShapeView(
                    holeLength: scale * 74,
                    fullLength: scale * 220,
                    opacity: 0.4
                )
            }
            
            DonutShapeView(
                holeLength: scale * (230 - 5),
                fullLength: scale * 230
            )
            
        } //: ZStack
    }
}

// MARK: - Preview
struct CDView_Previews: PreviewProvider {
    static var previews: some View {
        
        CDView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
            .previewDisplayName("Without Album Art")
        
        CDView(imageName: "INeverDie")
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
            .previewDisplayName("With Album Art")
        
        CDView(scale: 0.5)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
            .previewDisplayName("Scaled down")
    }
}

