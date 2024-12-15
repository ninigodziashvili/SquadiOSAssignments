//
//  Extensions.swift
//  29. SwiftUI Essentials
//
//  Created by Despo on 09.12.24.
//

import SwiftUI

extension Text {
    func styledText(_ fontSize: CGFloat, _ textColor: Color = .black, _ weight: Font.Weight = .regular) -> some View {
        self
            .font(.system(size: fontSize))
            .fontWeight(weight)
            .foregroundStyle(textColor)
            .fixedSize()
    }
}

extension View {
    func styledBox() -> some View {
        self
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.boxBg)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension TextField {
    func styledField() -> some View {
        self
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
