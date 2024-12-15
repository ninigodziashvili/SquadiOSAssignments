//
//  TimerDetailView.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 12.12.24.
//

import SwiftUI

struct TimerDetailView: View {
    
    let name: String
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: TimerViewModel
    var totalTimeWorked: TimeInterval
    
    var body: some View {
        ZStack {
            gradient
            VStack {
                timerName
                VStack(spacing: 22) {
                    clockImage
                    Text("ხანგრძლივობა")
                    timerDuration
                }
                .roundedRectangleStyle(width: 357, height: 306)
                ScrollView {
                    VStack {
                        HStack {
                            Text("აქტივობის ისტორია")
                                .fontAppearance(size: 24)
                            Spacer()
                        }
                        .padding(.leading, 30)
                        .padding()
                        
                        Divider()
                            .frame(width: 357, height: 2)
                            .background(.white)
                            .padding(.bottom)
                        
                        VStack {
                            HStack(spacing: 200) {
                                Text("თარიღი")
                                Text("დრო")
                            }
                            .padding(.bottom)
                            HStack(spacing: 150) {
                                ForEach(viewModel.activities, id: \.date) { activity in
                                    VStack {
                                        Text(activity.date.formatDate())
                                    }
                                    VStack {
                                        Text(activity.timeWorked.formatTimeInterval())
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .roundedRectangleStyle(width: 360, height: 383)
            }
            
            .foregroundStyle(.white)
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .background(.black)
    }
    
    private var backButton: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
        .foregroundColor(.white)
    }
    
    private var timerDuration: some View {
        Text(viewModel.totalTimeWorked.formatTimeInterval())
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .font(.system(size: 36, weight: .heavy))
    }
    
    private var clockImage: some View {
        Image("clock")
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
    }
    
    private var timerName: some View {
        Text(name)
            .fontAppearance(size: 24)
            .frame(maxWidth: .infinity,maxHeight: 120)
            .background(Color.customGray)
            .padding(.top)
    }
    
    private var gradient: some View {
        LinearGradient(colors: [Color.customGray], startPoint: .top, endPoint: .bottom)
    }
}

#Preview {
    TimerDetailView(name: "name", viewModel: TimerViewModel(), totalTimeWorked: TimeInterval())
}
