//
//  DonutShapeView.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import SwiftUI

struct DonutShapeView: View {
    // MARK: - Properties
    var holeLength: CGFloat = 24.86
    var fullLength: CGFloat = 38.72
    var opacity = 0.2

    // MARK: - Body
    var body: some View {
        Donut(hole: holeLength)
            .fill(
                Colors.primary.color.opacity(opacity),
                style: FillStyle(eoFill: true)
            )
            .frame(width: fullLength, height: fullLength)
    }
}

// MARK: - Preview
struct DonutShapeView_Previews: PreviewProvider {
    static var previews: some View {
        DonutShapeView(
            holeLength: 24.82,
            fullLength: 38.72
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
    }
}

struct Donut: Shape {
    var hole: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
    
        // Outer
        path.addEllipse(
            in: .init(
                origin: .zero,
                size: .init(
                    width: rect.width,
                    height: rect.height
                )
            )
        )
        
        // Inner
        let holeOrigin = (rect.width - hole) / 2
        path.addEllipse(
            in: .init(
                origin: .init(x: holeOrigin, y: holeOrigin),
                size: .init(width: hole, height: hole)
            )
        )
        
        return path
    }
}
