//
//  TimerDetailsView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 13.12.24.
//

import SwiftUI

struct TimerDetailsView: View {
    @StateObject private var viewModel = TimerDetailsViewModel()
    @Environment(\.dismiss) private var dismiss
    var timer: TimerModel
    
    var body: some View {
        VStack (spacing: 12){
            ZStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 25)
                    }
                    Spacer()
                }
                Text(timer.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            .background(Color.mineShaft)
            
            GeometryReader { geometry in
                let isSmallDevice = geometry.size.width < 376
                
                VStack(spacing: isSmallDevice ? 16 : 22) {
                    Image("stopwatch")
                    Text("ხანგრძლივობა")
                        .foregroundStyle(.white)
                        .font(.system(size: isSmallDevice ? 16 : 18, weight: .medium))
                    Text(timer.formatedTime(from: timer.defaultDuration))
                        .foregroundStyle(.azure)
                        .font(.system(size: isSmallDevice ? 32 : 38, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(
                    top: isSmallDevice ? 10 : 20,
                    leading: 20,
                    bottom: isSmallDevice ? 10 : 20,
                    trailing: 20
                ))
                .background(.mineShaft)
                .cornerRadius(16)
                .padding(.horizontal, 15)
            }
            .frame(maxHeight: 220)
            
            StatisticsView(timer: timer)
            
            VStack (spacing: 5) {
                if timer.history.isEmpty {
                    Spacer()
                    Text("ტაიმერის ისტორია ცარიელია")
                        .foregroundStyle(.boulder)
                    Spacer()
                } else {
                    Text("აქტივობის ისტორია")
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    List {
                        ForEach(timer.history.reversed(), id: \.id) { historyEntry in
                            Section(header: Text(historyEntry.date).sectionHeaderModifier()) {
                                ForEach(historyEntry.sessions.reversed(), id: \.id) { session in
                                    HStack {
                                        Text("\(session.startTime)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(timer.formatedTime(from: session.duration))
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowSeparatorTint(.boulder)
                            .listSectionSpacing(10)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.grouped)
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 15)
        }
        .environmentObject(viewModel)
        .background(.codGray)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TimerDetailsView(timer: TimerModel(
        name: "ვარჯიში",
        duration: 2700,
        defaultDuration: 2700,
        history: [
            HistoryEntry(
                date: "15 დეკ 2024",
                sessions: [
                    HistoryEntry.Session(startTime: "10:00:00", endTime: "10:30:00", duration: 1800),
                    HistoryEntry.Session(startTime: "12:00:00", endTime: "12:15:00", duration: 900)
                ]
            ),
            HistoryEntry(
                date: "14 დეკ 2024",
                sessions: [
                    HistoryEntry.Session(startTime: "08:30:00", endTime: "08:50:00", duration: 1200)
                ]
            )
        ]
    ))
}
