//
//  ContentView.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/11/24.
//

import SwiftUI
import Combine

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("ტაიმერები")
                    .frame(maxWidth: .infinity, minHeight: 109, alignment: .leading)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                    .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                    .background(Color(UIColor(hex: "#2C2C2C")))
                
                VStack {
                    if viewModel.timers.isEmpty {
                        Text("No timers available.")
                            .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                            .padding()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.timers) { timer in
                                    NavigationLink(destination: TimerDetailView(timer: timer, viewModel: viewModel)) {
                                        TimerTab(timerId: timer.id)
                                            .environmentObject(viewModel)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.black))
                
                TimerProperties(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: 191)
                    .background(Color(UIColor(hex: "#2C2C2C")))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    TimerView()
}

