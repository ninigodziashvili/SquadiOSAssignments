//
//  TimerTextField.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//

import SwiftUI

struct TimerTextField: View {
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color(UIColor(hex: "#757575"))))
            .frame(height: 39)
            .padding(.horizontal)
            .background(Color(UIColor(hex: "#3A3A3C")))
            .cornerRadius(8)
            .keyboardType(keyboardType)
            .foregroundStyle(Color.white)
    }
}
