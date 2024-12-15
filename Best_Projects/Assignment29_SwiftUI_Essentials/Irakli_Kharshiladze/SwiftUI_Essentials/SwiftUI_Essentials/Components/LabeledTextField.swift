//
//  LabeledTextField.swift
//  SwiftUI_Essentials
//
//  Created by irakli kharshiladze on 09.12.24.
//
import SwiftUI

struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .textCase(.uppercase)
                .customText(size: 9)
            TextField(placeholder, text: $text)
                .customTextField()
        }
    }
}
