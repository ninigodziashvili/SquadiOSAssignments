//
//  Extensions.swift
//  31. SwiftUI Navigation
//
//  Created by Despo on 13.12.24.
//

import SwiftUI

extension Button{
    func timerButtonStyles(bgColor: Color) -> some View {
        self
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension TextField {
    func styledField() -> some View {
        self
            .frame(height: 40)
            .padding(.horizontal, 12)
            .background(.shipGray)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundStyle(.white)
    }
}

extension Text {
    func styledText(_ col: Color, _ size: CGFloat, _ weight: Font.Weight = .regular) -> some View {
        self
            .foregroundStyle(col)
            .font(.system(size: size))
            .fontWeight(weight)
    }
}
