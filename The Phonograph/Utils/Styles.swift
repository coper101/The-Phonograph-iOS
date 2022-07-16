//
//  Styles.swift
//  The Phonograph
//
//  Created by Wind Versi on 11/7/22.
//

import SwiftUI

// MARK: - Color
enum Colors: String {
    case background = "Black"
    case primary = "White"
    var color: Color {
        Color(self.rawValue)
    }
}

// MARK: - Icon
enum Icons: String {
    case profileImagePlaceholder = "Profile Image Placeholder"
    case play = "Play Icon"
    case pause = "Pause Icon"
    case minimize = "Minimize Icon"
    var image: Image {
        Image(self.rawValue)
    }
}

// MARK: - Font
enum Fonts: String {
    case DMSansBold = "DMSans-Bold"
    var value: String {
        self.rawValue
    }
}

// MARK: - Text
struct CustomText: ViewModifier {
    var foregroundColor: Color
    var font: String
    var size: Int
    var maxWidth: CGFloat?
    var alignment: Alignment
    var lineLimit: Int?
    var lineSpacing: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .font(
                Font.custom(
                    font,
                    size: CGFloat(size)
                )
            )
            .frame(
                maxWidth: maxWidth,
                alignment: alignment
            )
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
    }
}

extension View {
    
    /// Sets the style of the Text
    ///
    /// - Parameters:
    ///   - foregroundColor: The color of the text
    ///   - font: The custom font e.g. "Arial-Bold"
    ///   - size: The font size
    ///   - maxWidth: The text will fill all the available width of its parent
    ///   - alignment: The alignment of the text relative to its width
    ///   - linelimit: Limit the text per line. Overflowing text in single line will be truncated with ...
    ///   - lineSpacing: The space between lines of text
    ///
    /// - Returns: A Text View with new Style
    func textStyle(
        foregroundColor: Colors = .primary,
        font: Fonts = .DMSansBold,
        size: Int,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .leading,
        lineLimit: Int? = nil,
        lineSpacing: CGFloat = 0
    ) -> some View {
        self.modifier(
            CustomText(
                foregroundColor: foregroundColor.color,
                font: font.value,
                size: size,
                maxWidth: maxWidth,
                alignment: alignment,
                lineLimit: lineLimit,
                lineSpacing: lineSpacing
            )
        )
    }
    
}


// MARK: - Frame
struct FrameModifier: ViewModifier {
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content.frame(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }
}

extension View {
    
    func fillMaxHeight(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: nil,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    func fillMaxWidth(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: nil,
                alignment: alignment
            )
        )
    }
    
    func fillMaxSize(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
}

