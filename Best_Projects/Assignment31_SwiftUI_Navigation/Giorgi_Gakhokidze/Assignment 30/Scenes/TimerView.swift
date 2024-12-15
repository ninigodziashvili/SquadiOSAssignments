//
//  Timer.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 11.12.24.
//

import SwiftUI


struct TimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel
    let name: String
    let removeAction: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .foregroundStyle(.white)
                Spacer()
                Button {
                    removeAction?()
                } label: {
                    Label("", systemImage: "trash")
                }
                .foregroundStyle(.red)

            }
            .padding([.horizontal, .bottom])
            
            
            Text(viewModel.timeString)
                .font(.largeTitle)
                .foregroundStyle(.blue)
                .font(.system(size: 36, weight: .heavy))
            HStack {
                Button(viewModel.isRunning ? "პაუზა": "დაწყება") {
                    if viewModel.isRunning {
                        viewModel.pauseTimer()
                    } else {
                        viewModel.startTimer()
                    }
                }
                .roundedRectangleStyle(width: 110,height: 39, cornerRadius: 10, color: viewModel.isRunning ? .yellow : .green)
                Button("გადატვირთვა") {
                    viewModel.resetTimer()
                }
                    .roundedRectangleStyle(width: 157, height: 39, cornerRadius: 10, color: .red)
            }
            .foregroundStyle(.white)
        }
        .padding(.horizontal)
        .roundedRectangleStyle()
        .padding()
    }
}


