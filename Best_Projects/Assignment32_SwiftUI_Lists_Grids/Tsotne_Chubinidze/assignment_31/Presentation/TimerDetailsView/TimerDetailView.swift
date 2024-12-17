//
//  TimerDetailView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import SwiftUI
import MyDateFormatter

struct TimerDetailView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var timer: TimerModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    ZStack {
                        HStack {
                            Text(timer.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        HStack {
                            Button {
                                coordinator.pop()
                            } label: {
                                Image("customBack")
                                    .padding([.leading])
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    .background(Color("customDarkGray"))
                }
                VStack {
                    TitleView(timer: timer)
                        .padding([.leading, .trailing, .top])
                    InfoView(timer: timer)
                        .padding([.leading, .trailing, .top])
                    HistoryView(timerHistory: timer)
                }
                .background(Color("customBlack"))
            }
        }
    }
}

struct HistoryView: View {
    var timerHistory: TimerModel
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("აქტივობის ისტორია")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                Spacer()
            }
            
            List {
                ForEach(timerHistory.history.keys.sorted(by: >), id: \.self) { day in
                    Section(header: Text(day)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color("customDustyGray"))) {
                            
                            ForEach((timerHistory.history[day] ?? []).reversed(), id: \.startTime) { entry in
                                VStack(spacing: 0) {
                                    separator(thickness: 1, opacity: 0.2)
                                        .padding(.bottom, 12)
                                    HStack {
                                        Text(entry.startTime)
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(entry.useTimeInSeconds.asTimes)
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .padding(.top, -20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

