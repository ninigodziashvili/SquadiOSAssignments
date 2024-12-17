//
//  ButtonModifier.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 11.12.24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    @State var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(backgroundColor)
            .cornerRadius(8)
    }
}

struct TextFieldModifier: ViewModifier {
    @State var alignment: TextAlignment
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.white)
            .padding(8)
            .background(Color.shipGray)
            .cornerRadius(8)
            .multilineTextAlignment(alignment)
            .keyboardType(alignment == .center ? .numberPad : .default)
    }
}

struct SectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(Color.boulder)
    }
}

extension View {
    public func buttonModifier(backgroundColor: Color) -> some View {
        self.modifier(ButtonModifier(backgroundColor: backgroundColor))
    }
    
    public func textFieldModifier(alignment: TextAlignment) -> some View {
        self.modifier(TextFieldModifier(alignment: alignment))
    }
    
    public func sectionHeaderModifier() -> some View {
        self.modifier(SectionHeaderModifier())
    }
}
