//
//  CustomModifiers.swift
//  SwiftUI_Essentials
//
//  Created by irakli kharshiladze on 08.12.24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    let fontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .foregroundStyle(Color.textcolor)
    }
}

struct TitleTextModifier: ViewModifier {
    let fontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundStyle(Color.black)
    }
}

struct CustomTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .regular))
            .frame(height: 30)
            .padding(5)
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.bordercolor, lineWidth: 1)
            )
    }
}

extension View {
    func customTitle(size: CGFloat) -> some View {
        modifier(TitleTextModifier(fontSize: size))
    }
    
    func customText(size: CGFloat) -> some View {
        modifier(TextModifier(fontSize: size))
    }
    
    func customTextField() -> some View {
        modifier(CustomTextField())
    }
}
