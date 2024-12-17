//
//  QuickTimersView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 15.12.24.
//
import SwiftUI

struct QuickTimersView: View {
    @EnvironmentObject private var coordinator: Coordinator
    private var viewmodel = QuickTimersViewModel()
    var parentViewModel: TimerListViewModel?
    
    init(parentViewModel: TimerListViewModel) {
        self.parentViewModel = parentViewModel
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                Text("სწრაფი ტაიმერები")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding([.leading, .bottom], 15)
                Spacer()
            }
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(viewmodel.quiickTimers) { item in
                    MiniTimerView(timer: item)
                        .padding(.bottom, 8)
                        .onTapGesture {
                            parentViewModel?.addTimer(item)
                            coordinator.dismissSheet()
                        }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .background(Color("customBlack"))
    }
}

struct MiniTimerView: View {
    var timer: TimerModel
    var body: some View {
        ZStack {
            VStack {
                Text("\(timer.timeAmount.asTimes.asShortTime())")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color("customBlue"))
                    .padding(.bottom, 4)
                Text("\(timer.name)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 90)
            }
            .frame(width: 110, height: 100)
            .background(Color("customDarkGray"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
    }
}
