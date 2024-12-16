//
//  ContentView.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 11.12.24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.customGray], startPoint: .top, endPoint: .bottom)
                VStack {
                    HStack {
                        Text("ტაიმერები")
                            .foregroundStyle(.white)
                            .fontAppearance(size: 24)
                    }
                    .frame(maxWidth: .infinity,maxHeight: 120, alignment: .leading)
                    .padding()
                    .background(Color.customGray)
                    
                    ScrollView {
                        ForEach(viewModel.timers.indices, id: \.self) { index in
                            NavigationLink(destination: TimerDetailView(name: viewModel.timers[index].name, viewModel: viewModel.timers[index].viewModel, totalTimeWorked: TimeInterval())) {
                                
                                TimerView(viewModel: viewModel.timers[index].viewModel, name: viewModel.timers[index].name) {
                                    viewModel.removeTimer(at: index)
                                }
                            }
                        }
                    }
                    AddTimeVIew(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                }
            }
            .background(.black)
            .ignoresSafeArea()
        }
    
    }
}

#Preview {
    ContentView()
}
