//
//  AddTimeVIew.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 11.12.24.
//

import SwiftUI

struct AddTimeVIew: View {
    @State private var name = ""
    @State private var hour = ""
    @State private var minute = ""
    @State private var second = ""
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            nameTextField
            timeTextFields
            addButton
                .buttonStyle()
        }
        .padding()
        .foregroundStyle(Color.grayText)
        .background(Color.customGray)
        
    }
    
    private var nameTextField: some View {
        TextField("", text: $name, prompt: Text("ტაიმერის სახელი").foregroundColor(Color.grayText))
            .textFieldStyle()
        
    }
    
    private var addButton: some View {
        Button("დამატება") {
            if let hours = Int(hour), let minutes = Int(minute), let seconds = Int(second), !name.isEmpty {
                viewModel.createTimer(name: name, hours: hours, minutes: minutes, seconds: seconds)
                name = ""
                hour = ""
                minute = ""
                second = ""
            }
        }
    }
    
    private var timeTextFields: some View {
        HStack(spacing: 20) {
            TextField("", text: $hour, prompt: Text("სთ").foregroundColor(Color.grayText))
                .textFieldStyle()
            TextField("", text: $minute, prompt: Text("წთ").foregroundColor(Color.grayText))
                .textFieldStyle()
            TextField("", text: $second, prompt: Text(" წმ").foregroundColor(Color.grayText))
                .textFieldStyle()
        }
        .padding(.vertical, 5)
    }
}


#Preview {
    AddTimeVIew(viewModel: TimerViewModel())
}
