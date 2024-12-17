//
//  TimerDetailsView.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 13.12.24.
//

import SwiftUI

struct TimerDetailsView: View {
    @ObservedObject var timer: TimerModel
    @Environment(\.presentationMode) var presentationMode
    
    private var totalDuration: TimeInterval {
        timer.usageHistory.reduce(0) { $0 + durationToTimeInterval($1.duration) }
    }
    
    private var averageDuration: TimeInterval {
        guard !timer.usageHistory.isEmpty else { return 0 }
        return totalDuration / Double(timer.usageHistory.count)
    }
    
    private var sessionCount: Int {
        timer.usageHistory.count
    }
    
    var body: some View {
        ZStack {
            Color(red: 29/255, green: 29/255, blue: 29/255)
                .ignoresSafeArea()
            
            VStack {
                Text(timer.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 65)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                
                VStack {
                    VStack {
                        Image(systemName: "timer")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        
                        Text("ხანგრძლივობა")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(5)
                        
                        Text("\(String(format: "%02d", timer.originalHours)):\(String(format: "%02d", timer.originalMinutes)):\(String(format: "%02d", timer.originalSeconds))")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("დღევანდელი სესიები")
                                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            Spacer()
                            Text("\(sessionCount) სესია")
                                .foregroundColor(Color.white)
                        }
                        .padding(8)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                        
                        HStack {
                            Text("საშუალო ხანგრძლივობა")
                                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            Spacer()
                            Text(timeIntervalToDuration(averageDuration))
                                .foregroundColor(Color.white)
                        }
                        .padding(8)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                        
                        HStack {
                            Text("ჯამური ხანგრძლივობა")
                                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            Spacer()
                            Text(timeIntervalToDuration(totalDuration))
                                .foregroundColor(Color.white)
                        }
                        .padding(8)
                    }
                    .padding()
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .cornerRadius(10)
                    .font(.system(size: 15, weight: .semibold))
                    
                    Spacer()
                    
                    ZStack {
                        Color(red: 29/255, green: 29/255, blue: 29/255)
                            .cornerRadius(10)
                        
                        List {
                            Section(header: Text("აქტივობის ისტორია")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.vertical, 5)
                                .listRowBackground(Color(red: 29/255, green: 29/255, blue: 29/255))
                                .cornerRadius(10)) {
                                    
                                    ForEach(groupedUsageHistory(), id: \.key) { date, usageEntries in
                                        Section(header: Text(dateFormatter(date: date))
                                            .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                                            .font(.system(size: 14))
                                            .padding(.vertical, 5)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .listRowBackground(Color(red: 29/255, green: 29/255, blue: 29/255))
                                            .cornerRadius(10)) {
                                                ForEach(usageEntries, id: \.timestamp) { usage in
                                                    HStack {
                                                        Text(timeFormatter(date: usage.timestamp))
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.white)
                                                        Spacer()
                                                        Text(usage.duration)
                                                            .font(.system(size: 14, weight: .medium))
                                                            .foregroundColor(.white)
                                                    }
                                                    .padding(.leading)
                                                    .padding(.trailing)
                                                    .cornerRadius(10)
                                                    .listRowBackground(Color(red: 29/255, green: 29/255, blue: 29/255))
                                                }
                                            }
                                    }
                                }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .background(Color(red: 29/255, green: 29/255, blue: 29/255))
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private func groupedUsageHistory() -> [(key: Date, value: [TimerModel.TimerUsage])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: timer.usageHistory) { usage in
            return calendar.startOfDay(for: usage.timestamp)
        }
        
        return grouped.sorted { $0.key > $1.key }
    }
    
    private func durationToTimeInterval(_ duration: String) -> TimeInterval {
        let components = duration.split(separator: ":").map { String($0) }
        guard components.count == 3,
              let hours = Double(components[0]),
              let minutes = Double(components[1]),
              let seconds = Double(components[2]) else {
            return 0
        }
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    private func timeIntervalToDuration(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    private func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ka_GE")
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    private func timeFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ka_GE")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

