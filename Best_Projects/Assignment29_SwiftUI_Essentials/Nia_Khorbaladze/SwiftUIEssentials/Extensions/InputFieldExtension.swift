//
//  InputFieldExtension.swift
//  SwiftUIEssentials
//
//  Created by Nkhorbaladze on 09.12.24.
//

import SwiftUI

extension View {
    func inputField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(placeholder, text: text)
                .padding(.horizontal, 15)
                .frame(height: 35)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 3)
    }
}
