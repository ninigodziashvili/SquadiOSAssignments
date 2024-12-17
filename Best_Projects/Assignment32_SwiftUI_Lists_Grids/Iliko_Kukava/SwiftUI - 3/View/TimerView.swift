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
    @State private var showFastTimerSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("ტაიმერები")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .padding(.leading, 20)
                            .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                        
                        Spacer()
                        
                        Button(action: {
                            showFastTimerSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(UIColor(hex: "#FFFFFF")))
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 109, alignment: .leading)
                    .background(Color(UIColor(hex: "#2C2C2C")))

                    VStack {
                        if viewModel.timers.isEmpty {
                            Text("გთხოვთ დაამატოთ ტაიმერი.")
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
                .blur(radius: showFastTimerSheet ? 10 : 0)
                .animation(.easeInOut, value: showFastTimerSheet)
            
                if showFastTimerSheet {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showFastTimerSheet = false
                        }
                }
            }
        }
        .sheet(isPresented: $showFastTimerSheet) {
            FastTimerSheet(viewModel: viewModel)
        }
    }
}


struct FastTimerSheet: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel: TimerViewModel
    @Environment(\.dismiss) private var dismiss
    
    let fastTimers = [
        ("ვარჯიში", "00:30:00"),
        ("მეცადინეობა", "01:00:00"),
        ("შესვენება", "00:10:00"),
        ("მედიტაცია", "00:15:00"),
        ("წაძინება", "00:20:00"),
        ("საჭმლის მომზადება", "00:45:00"),
        ("დასუფთავება", "00:25:00"),
        ("შეხვედრა", "00:50:00"),
        ("თამაში", "02:00:00"),
        ("კითხვა", "00:40:00"),
        ("იოგა", "00:30:00"),
        ("ბაღის საქმეები", "01:00:00"),
        ("სირვილი", "00:50:00"),
        ("ცურვა", "00:45:00"),
        ("წერა", "01:15:00"),
        ("სრიალი", "01:30:00"),
        ("კოდირება", "02:30:00"),
        ("სოციალური ქსელი", "00:20:00")
    ]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("სწრაფი ტაიმერები")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.leading, 20)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(fastTimers, id: \.0) { timer in
                        CardView(
                            title: timer.0,
                            time: timer.1,
                            clickTab: {
                                let components = timer.1.split(separator: ":").map { Int($0) ?? 0 }
                                let hours = components[0]
                                let minutes = components[1]
                                let seconds = components[2]
                                viewModel.timerName = timer.0
                                viewModel.hours = "\(hours)"
                                viewModel.minutes = "\(minutes)"
                                viewModel.seconds = "\(seconds)"
                                viewModel.addTimer()
                                dismiss()
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color(.black))
        .presentationDetents([.fraction(0.5), .fraction(0.8)])
    }
}


struct CardView: View {
    let title: String
    let time: String
    let clickTab: () -> Void
    @State private var isTapped = false

    var body: some View {
        
        VStack(spacing: 8) {

            Text(time)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(Color(UIColor(hex: "#007AFF")))
            
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
        }
        .frame(width: 108, height: 94)
        .background(Color(UIColor(hex: "#2C2C2C")))
        .cornerRadius(10)
        .scaleEffect(isTapped ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isTapped)
        .onTapGesture {
            isTapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isTapped = false
                clickTab()
            }
        }
        
    }
}


#Preview {
    TimerView()
}

