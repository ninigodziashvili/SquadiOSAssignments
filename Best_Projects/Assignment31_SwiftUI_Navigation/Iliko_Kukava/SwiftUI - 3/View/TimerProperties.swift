//
//  TimerProperties.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//

import SwiftUI

struct TimerProperties: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TimerTextField(text: $viewModel.timerName, placeholder: "ტაიმერის სახელი ...")
                .padding(.horizontal)
            
            HStack(spacing: 10) {
                TimerTextField(text: $viewModel.hours, placeholder: "სთ", keyboardType: .numberPad)
                TimerTextField(text: $viewModel.minutes, placeholder: "წთ", keyboardType: .numberPad)
                TimerTextField(text: $viewModel.seconds, placeholder: "წმ", keyboardType: .numberPad)
            }
            .padding(.horizontal)
            
            Button(action: {
                viewModel.addTimer()
            }) {
                Text("დამატება")
                    .frame(maxWidth: 155, maxHeight: 42)
                    .background(Color(UIColor(hex: "#007AFF")))
                    .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding(.top, 21)
    }
}
