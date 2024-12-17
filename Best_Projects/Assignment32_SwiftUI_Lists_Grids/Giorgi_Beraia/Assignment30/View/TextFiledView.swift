//
//  TextFiledMini.swift
//  Assignment30
//
//  Created by Giorgi on 11.12.24.
//

import SwiftUI

struct TextFiledMini: View {
    @Binding var text: String
    var title: String
    
    var body: some View{
        TextField("", text: $text, prompt: Text(title)
            .foregroundStyle(.appPlaceHolder))
            .padding(.horizontal, 38)
            .foregroundStyle(.white)
            .frame(height: 39)
            .background(.appFiledGray)
            .cornerRadius(8)
    }
}
