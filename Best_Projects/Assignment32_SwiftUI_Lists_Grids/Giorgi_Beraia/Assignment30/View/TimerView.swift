//
//  View.swift
//  Assignment30
//
//  Created by Giorgi on 16.12.24.
//
import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimersViewModelREAL
    @ObservedObject var timer: TimerModel
    
    private var btnColor: Color {
        timer.isRunning ? .orange : .green
    }
    private var btnText: String {
        timer.isRunning ? "პაუზა" : "დაწყება"
    }
    
    var body: some View {
            ZStack{
                VStack(spacing: 15){
                    Text(timer.timerName)
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading )
                        .padding(.leading, 20)
                   
                    Text("\(String(format: "%02d", timer.hours)):\(String(format: "%02d", timer.minutes)):\(String(format: "%02d", timer.seconds))")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.appBlue)
                    
                    HStack(spacing: 10){
                        Button(btnText) {
                            viewModel.toggleTimerRunning(timer: timer)
                        }
                        .frame(height: 39)
                        .padding(.horizontal, 20)
                        .background(btnColor)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        
                        Button("გადატვირთვა") {
                            timer.timeDict[timer.startTime] = timer.duration
                            viewModel.resetTimer(timer: timer)
                        }
                        .frame(height: 39)
                        .padding(.horizontal, 20)
                        .background(.appRed)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                    }
                }
                
                Image(.bin)
                    .offset(x: 160, y:-70)
                    .onTapGesture {
                        viewModel.deleteTimer(id: timer.id)
                    }
            }
            .frame(width: 360, height: 177)
            .background(.appGray)
            .cornerRadius(8)
        }
}
