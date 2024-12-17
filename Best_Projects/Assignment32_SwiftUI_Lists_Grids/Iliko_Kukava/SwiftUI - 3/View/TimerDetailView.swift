//
//  TimerDetailView.swift
//  SwiftUI - 3
//
//  Created by iliko on 12/13/24.
//

import SwiftUI

struct TimerDetailView: View {
    let timer: TimerModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TimerViewModel

    var summedTimers: [Date: (totalHours: Int, totalMinutes: Int, totalSeconds: Int)] {
        viewModel.sumTimersByDate()
    }

    var body: some View {
        VStack(spacing: 0) {
            headerView
            contentView
        }
        .navigationBarHidden(true)
    }
}

extension TimerDetailView {
    private var headerView: some View {
        ZStack {
            HStack {
                backButton
                Spacer()
            }

            Text(timer.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                .lineLimit(1)
        }
        .frame(height: 73)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hex: "#2C2C2C")))
    }


    private var backButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 21, height: 21)
                .foregroundColor(Color(UIColor(hex: "#FFFFFF")))
        }
        .padding(.leading, 16)
    }

    private var contentView: some View {
        VStack(spacing: 10) {
            durationView
            todayActivityHistoryView
            activityHistoryView
            Spacer()
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hex: "#000000")))
    }

    private var durationView: some View {
        VStack(spacing: 22) {
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .foregroundColor(Color(.systemOrange))

            Text("ხანგრძლივობა")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))

            Text(formattedTime(for: timer))
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Color(UIColor(hex: "#007AFF")))
        }
        .padding()
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hex: "#2C2C2C")))
        .cornerRadius(16)
    }
    
    private var todayActivityHistoryView: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                HistoryRowView(
                    title: "დღევანდელი სესიები:",
                    value: "\(viewModel.daySessionsCount(for: timer)) სესია",
                    titleColor: Color(UIColor(hex: "#999999")),
                    valueColor: Color(UIColor(hex: "#FFFFFF"))
                )
                
                HistoryRowView(
                    title: "საშუალო ხანგრძლივობა:",
                    value: viewModel.dayAverageTime(for: timer),
                    titleColor: Color(UIColor(hex: "#999999")),
                    valueColor: Color(UIColor(hex: "#FFFFFF"))
                )
                
                HistoryRowView(
                    title: "ჯამური დრო:",
                    value: viewModel.dayTotalTime(for: timer),
                    titleColor: Color(UIColor(hex: "#999999")),
                    valueColor: Color(UIColor(hex: "#FFFFFF"))
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(15)
        .background(Color(UIColor(hex: "#2C2C2C")))
        .cornerRadius(16)
    }
    
    private struct HistoryRowView: View {
        let title: String
        let value: String
        let titleColor: Color
        let valueColor: Color
        
        var body: some View {
            HStack {
                Text(title)
                    .foregroundStyle(titleColor)
                    .font(.body)
                Spacer()
                Text(value)
                    .foregroundStyle(valueColor)
                    .font(.body)
            }
            Divider()
                .frame(height: 1)
                .background(Color(.darkGray))
        }
    }

    private var activityHistoryView: some View {
        VStack(spacing: 16) {
            historyHeader
            historyList
        }
        .padding(15)
        .background(Color.clear)

        .cornerRadius(16)
    }

    private var historyHeader: some View {
        HStack {
            Text("აქტივობის ისტორია")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal, 0)
    }


    private var historyTableHeader: some View {
        HStack(spacing: 50) {
            Text("თარიღი")
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                .frame(width: 160)
            Text("დრო")
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
                .frame(width: 120)
        }
    }

    private var historyList: some View {
        List {
            ForEach(summedTimers.keys.sorted(), id: \.self) { date in
                Section(
                    header: VStack(alignment: .leading, spacing: 4) {
                        Text(formatDate(date))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                        
                        Divider()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 20)
                            .background(Color(UIColor(hex: "#EAEAEF")))
                    }
                    .background(Color(.black))
                ) {
                    let timersForDate = viewModel.timersForDay(of: TimerModel(name: "", hours: 0, minutes: 0, seconds: 0, dateCreated: date))
                    ForEach(timersForDate.indices, id: \.self) { index in
                        VStack(spacing: 0) {
                            exactTimerRow(timer: timersForDate[index])
                            
                            
                            Divider()
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .background(Color(UIColor(hex: "#6E6E6E")))
                        }
                    }
                }
                .listRowBackground(Color(.clear))
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(PlainListStyle())
        .background(Color(.clear))
        .cornerRadius(8)
    }


    private func exactTimerRow(timer: TimerModel) -> some View {
        HStack {
            Text(formatExactTime(timer.dateCreated))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(formatTime((timer.hours, timer.minutes, timer.seconds)))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 8)
        .background(Color(.clear))
    }

    private func formatExactTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" 
        return formatter.string(from: date)
    }

}

extension TimerDetailView {
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ka_GE") 
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }

    private func formatTime(_ time: (totalHours: Int, totalMinutes: Int, totalSeconds: Int)?) -> String {
        guard let time = time else { return "00:00:00" }
        return String(format: "%02d:%02d:%02d", time.totalHours, time.totalMinutes, time.totalSeconds)
    }

    private func formattedTime(for timer: TimerModel) -> String {
        String(format: "%02d:%02d:%02d", timer.originalHours, timer.originalMinutes, timer.originalSeconds)
    }
}

