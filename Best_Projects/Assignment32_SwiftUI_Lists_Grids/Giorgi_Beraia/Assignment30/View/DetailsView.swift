//
//  DetailsView.swift
//  Assignment30
//
//  Created by Giorgi on 13.12.24.
//

import SwiftUI

struct DetailsView: View {
    var timer: TimerModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            VStack(spacing: 12) {
                VStack(spacing: 22) {
                    Image(.clock)
                        .resizable()
                        .frame(width: 44, height: 44)
                    
                    Text("ხანგრძლივობა")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                    
                    Text("\(String(format: "%02d", timer.initialTime[0])):\(String(format: "%02d", timer.initialTime[1])):\(String(format: "%02d", timer.initialTime[2]))")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.appBlue)
                }
                .frame(width: 360, height: 180)
                .background(.appGray)
                .cornerRadius(8)
                .padding(.top, 16)
                
                VStack(spacing: 22) {
                    List {
                        Section {
                            HStack{
                                Text("დღევანდელი სესიები")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("\(timer.timeDict.count) სესია")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }.listRowBackground(Color.clear)
                            
                            HStack{
                                Text("საშუალო ხანგრძლივობა")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.gray)
                                Spacer()
                                
                                var midTimeInMinutes: String {
                                    let values = timer.timeDict.values
                                    guard !values.isEmpty else { return "0 წუთი" }
                                    let total = values.reduce(0, +)
                                    let averageSeconds = total / values.count
                                    
                                    let minutes = averageSeconds / 60
                                    let seconds = averageSeconds % 60
                                    
                                    if minutes == 0 {
                                        return "\(seconds) წამი"
                                    } else {
                                        return "\(minutes) წუთი \(seconds) წამი"
                                    }
                                }
                                
                                Text(midTimeInMinutes)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }.listRowBackground(Color.clear)
                            
                            HStack{
                                Text("ჯამური დრო")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.gray)
                                Spacer()
                                
                                var totalTime: String {
                                    let totalSeconds = timer.timeDict.values.reduce(0, +)
                                    let hours = totalSeconds / 3600
                                    let minutes = (totalSeconds % 3600) / 60
                                    let seconds = totalSeconds % 60
                                    
                                    if minutes == 0 {
                                        return "\(seconds) წამი"
                                    } else if hours == 0 {
                                        return "\(minutes) წთ \(seconds) წმ"
                                    } else {
                                        return "\(hours) სთ \(minutes) წთ \(seconds) წმ"
                                    }
                                }
                                
                                Text(totalTime)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.white)
                            }.listRowBackground(Color.clear)
                        }.listRowSeparatorTint(.gray)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(.appGray)
                    .padding(.top, 10)
                    .padding(.trailing, 15)
                }
                .frame(width: 360, height: 150)
                .background(.appGray)
                .cornerRadius(8)
                .padding(.top, 16)
                
                VStack{
                    Text("აქტივობის ისტორია")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                        .padding(.top, 31.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    List {
                        ForEach(groupTimersByDay(timer.timeDict).keys.sorted().reversed(), id: \.self) { day in
                            Section {
                                ForEach(groupTimersByDay(timer.timeDict)[day]!, id: \.0) { (date, value) in
                                    HStack{
                                        Text(timeFormatter.string(from: date)).foregroundStyle(.white)
                                        Spacer()
                                        Text(formatDuration(value)).foregroundStyle(.white)
                                    }.listRowBackground(Color.clear).listRowSeparatorTint(.gray)
                                }
                            } header: {
                                Text(dateFormatter.string(from: day)).foregroundStyle(.gray)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                .frame(width: 360)
                .cornerRadius(8)
            }.frame(maxHeight: .infinity)
        }.onAppear {
            setNavigationBarAppearance()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBlack)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.arrow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 19, height: 19)
                }
                .padding(.top, 20)
                .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .principal) {
                Text(timer.timerName)
                    .padding(.top, 20)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }
}
