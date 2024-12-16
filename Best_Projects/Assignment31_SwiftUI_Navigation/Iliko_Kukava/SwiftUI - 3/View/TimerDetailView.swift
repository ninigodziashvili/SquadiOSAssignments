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
        .frame(height: 108)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hex: "#2C2C2C")))
    }


    private var backButton: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .frame(width: 7, height: 12)
                .foregroundColor(Color(UIColor(hex: "#FFFFFF")))
        }
        .padding(.leading, 16)
    }

    private var contentView: some View {
        VStack(spacing: 10) {
            durationView
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
                .frame(width: 70, height: 70)
                .foregroundColor(Color(.systemOrange))

            Text("ხანგრძლივობა")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))

            Text(formattedTime(for: timer))
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Color(UIColor(hex: "#007AFF")))
        }
        .padding()
        .frame(height: 328)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor(hex: "#2C2C2C")))
        .cornerRadius(16)
    }

    private var activityHistoryView: some View {
        VStack(spacing: 16) {
            historyHeader
            Divider()
                .background(Color(UIColor(hex: "#EAEAEF")))
                .padding(.horizontal)
            historyTableHeader
            historyList
        }
        .padding(15)
        .background(Color(UIColor(hex: "#2C2C2C")))
        .cornerRadius(16)
    }

    private var historyHeader: some View {
        HStack {
            Text("აქტივობის ისტორია")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(UIColor(hex: "#FFFFFF")))
            Spacer()
        }
        .padding([.top, .leading])
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
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(summedTimers.keys.sorted(), id: \.self) { date in
                    if let time = summedTimers[date] {
                        historyRow(date: date, time: time)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }

    private func historyRow(date: Date, time: (totalHours: Int, totalMinutes: Int, totalSeconds: Int)) -> some View {
        HStack {
            Text(formatDate(date))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(formatTime(time))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 8)
        .background(Color.clear)
    }
}

extension TimerDetailView {
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
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

