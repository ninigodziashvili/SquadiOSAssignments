//
//  TimerTab.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//

import SwiftUI

struct TimerTab: View {
    @EnvironmentObject var viewModel: TimerViewModel
    let timerId: UUID

    var body: some View {
        if let timer = viewModel.timers.first(where: { $0.id == timerId }) {
            VStack(spacing: 10) {
                HStack {
                    Text(timer.name)
                        .font(.headline)
                        .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                        .padding(.leading, 15)

                    Spacer()

                    Button(action: {
                        viewModel.timers.removeAll { $0.id == timerId }
                        viewModel.saveTimers()
                    }) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color(UIColor(hex: "#FF3B30"))) 
                            .padding(.trailing, 15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .top)

                Text(viewModel.formattedTime(for: timerId))
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(Color(UIColor(hex: "#007AFF")))

                HStack(spacing: 20) {
                    Button(action: {
                        toggleTimer(for: timerId)
                    }) {
                        Text(timer.isRunning ? "პაუზა" : "დაწყება")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(timer.isRunning ? Color(UIColor(hex: "#FFCC00")) : Color(UIColor(hex: "#34C759")))
                            .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                            .cornerRadius(8)
                    }

                    Button(action: {
                        viewModel.resetTimer(for: timerId)
                    }) {
                        Text("გადატვირთვა")
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color(UIColor(hex: "#FF3B30")))
                            .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 15)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40, height: 177)
            .background(Color(UIColor(hex: "#3A3A3C")))
            .cornerRadius(16)
        }
    }
    
    private func toggleTimer(for timerId: UUID) {
        if let timer = viewModel.timers.first(where: { $0.id == timerId }) {
            if timer.isRunning {
                viewModel.pauseTimer(for: timerId)
            } else {
                viewModel.startTimer(for: timerId)
            }
        }
    }
}
