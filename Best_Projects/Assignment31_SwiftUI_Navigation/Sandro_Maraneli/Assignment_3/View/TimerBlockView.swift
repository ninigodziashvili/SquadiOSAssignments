//
//  TimerBlockView.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 11.12.24.
//

import SwiftUI

struct TimerBlockView: View {
    @ObservedObject var timer: TimerModel
    @EnvironmentObject var viewModel: TimerViewModel
    
    var body: some View {
        NavigationLink(destination: TimerDetailsView(timer: timer)) {
            VStack {
                HStack {
                    Text(timer.name)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18))
                    
                    Button(action: {
                        viewModel.deleteTimer(timer)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding(5)
                    }
                }
                .cornerRadius(10)
                
                Text("\(String(format: "%02d", timer.hours)):\(String(format: "%02d", timer.minutes)):\(String(format: "%02d", timer.seconds))")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color.blue)
                
                HStack {
                    Button(action: {
                        if timer.isRunning {
                            viewModel.stopTimer(timer)
                        } else {
                            viewModel.startTimer(timer)
                        }
                    }) {
                        Text(timer.isRunning ? "პაუზა" : "დაწყება")
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .background(timer.isRunning ? Color.orange : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        timer.reload()
                    }) {
                        Text("გადატვირთვა")
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color(red: 44/255, green: 44/255, blue: 44/255))
            .cornerRadius(8)
        }
    }
}

