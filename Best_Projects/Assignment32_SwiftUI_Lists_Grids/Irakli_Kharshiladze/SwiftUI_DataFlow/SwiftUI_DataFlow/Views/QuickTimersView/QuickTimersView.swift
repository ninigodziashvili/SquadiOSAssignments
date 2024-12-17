//
//  QuickTimersView.swift
//  SwiftUI_DataFlow
//
//  Created by irakli kharshiladze on 14.12.24.
//

import SwiftUI

struct QuickTimersView: View {
    @EnvironmentObject var viewModel: TimerViewModel
    @Environment(\.dismiss) private var dismiss
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack (spacing: 30) {
            Text("სწრაფი ტაიმერები")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.QuickTimers, id: \.self.id) { timer in
                        VStack (spacing: 8) {
                            Text(timer.formatedTime(from: timer.defaultDuration, isQuickTimer: true))
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.azure)
                            Text(timer.name)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 13))
                                .foregroundStyle(.white)
                        }
                        .onTapGesture {
                            viewModel.addQuickTimer(timer: timer)
                            dismiss()
                        }
                        .frame(maxWidth: 110, minHeight: 80)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 10)
                        .background(.mineShaft)
                        
                        .cornerRadius(20)
                        
                    }
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    let viewModel = TimerViewModel()
    viewModel.QuickTimers = [TimerModel(name: "ჩაის დაყენება", duration: 180, defaultDuration: 180), TimerModel(name: "HIIT ვარჯიში", duration: 420, defaultDuration: 420), TimerModel(name: "კვერცხის მოხარშვა", duration: 600, defaultDuration: 600), TimerModel(name: "შესვენება", duration: 900, defaultDuration: 900), TimerModel(name: "ყავის პაუზა", duration: 1200, defaultDuration: 1200), TimerModel(name: "პომოდორო", duration: 1500, defaultDuration: 1500), TimerModel(name: "მედიტაცია", duration: 1800, defaultDuration: 1800), TimerModel(name: "ვარჯიში", duration: 2700, defaultDuration: 2700), TimerModel(name: "სამუშაო სესია", duration: 3600, defaultDuration: 3600)]
    
    return QuickTimersView()
        .environmentObject(viewModel)
}
