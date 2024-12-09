//
//  ViewModifier.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 08.12.24.
//

import SwiftUI

struct CustomStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
                .frame(width: 265, height: 14, alignment: .leading)
                .font(Font.system(size: 12))
                .disableAutocorrection(true)     
        }
        .frame(width: 281, height: 30)
        .background(.white)
    }
}

struct TextStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tracking(1)
            .font(Font.system(size: 9))
            .foregroundStyle(.experienceLabel)
            .padding(.top, 7.96)
    }
}
