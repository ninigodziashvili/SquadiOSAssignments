//
//  StatisticsView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 15.12.24.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var viewModel: TimerDetailsViewModel
    var timer: TimerModel
    var body: some View {
        VStack (spacing: 12) {
            let statistics = viewModel.calculateTodaysStatistics(for: timer)
            HStack {
                Section(header: Text("დღევანდელი სესიები").sectionHeaderModifier()) {
                    Spacer()
                    Text("\(statistics.sessionCount) სესია")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 0.5)
            
            HStack {
                Section(header: Text("საშუალო ხანგრძლივობა").sectionHeaderModifier()) {
                    Spacer()
                    Text("\(viewModel.formatTimeForStats(from: statistics.averageLength))")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 0.5)
            
            HStack {
                Section(header: Text("ჯამური დრო").sectionHeaderModifier()) {
                    Spacer()
                    Text("\(viewModel.formatTimeForStats(from: statistics.totalLength))")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 0.5)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(.mineShaft)
        .cornerRadius(16)
        .padding(.horizontal, 15)
    }
}

#Preview {
    let viewModel = TimerDetailsViewModel()
    StatisticsView(
        timer: TimerModel(
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
        )
    )
    .environmentObject(viewModel)
}
