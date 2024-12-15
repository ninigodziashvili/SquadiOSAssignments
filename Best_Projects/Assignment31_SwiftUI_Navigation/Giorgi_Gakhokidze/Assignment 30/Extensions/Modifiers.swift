//
//  Modifiers.swift
//  Assignment 29
//
//  Created by Giorgi Gakhokidze on 09.12.24.
//

import SwiftUI

extension View {
    func textFieldStyle() -> some View {
        modifier(TextFieldStyle())
    }
    
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
    
    func fontAppearance(size: CGFloat = 15) -> some View {
        modifier(FontModifier(size: size))
    }
    
    func roundedRectangleStyle(width: CGFloat = 360, height: CGFloat = 175, cornerRadius: CGFloat = 24, color: Color = .customGray) -> some View {
        modifier(RoundedRectangleStyle(width: width, height: height, cornerRadius: cornerRadius, color: color))
    }

}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.grayColor))
    }
}

struct FontModifier: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .medium))
    }
}

struct RoundedRectangleStyle: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height)
            content
        }
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding()
            .frame(width: 150)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
    }
}


