//
//  UI+Extensions.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 14.12.24.
//
import SwiftUI

extension View {
    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        ZStack(alignment: .leading) {
            TextField("", text: text, prompt: Text(placeholder).foregroundColor(Color("customLightGray")))
                .foregroundStyle(.white)
                .padding()
                .background(Color("customGray"))
                .cornerRadius(10)
        }
    }
}

extension View {
    func customButton(color: Color, title: String, padding: CGFloat, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .padding()
            .padding([.leading, .trailing], padding)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

extension View {
    func headerView(title: String) -> some View {
        ZStack(alignment: .center) {
            HStack() {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                    .padding(.leading, 15)
                Spacer()
            }
            .background(Color("customDarkGray"))
        }
    }
}


extension View {
    func formLayout(padding: CGFloat = 20) -> some View {
        VStack(spacing: 20) {
            self
        }
        .padding(padding)
        .background(Color("customDarkGray"))
    }
}

extension View {
    func separator(thickness: Double, opacity: Double) -> some View {
        Rectangle()
            .fill(.white.opacity(opacity))
            .frame(height: CGFloat(thickness))
    }
}

extension View {
    func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color("customDustyGray"))
            Spacer()
            Text(value)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.white)
        }
    }
}
