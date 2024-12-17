//
//  FastTimerViewModel.swift
//  Assignment30
//
//  Created by Giorgi on 16.12.24.
//
import SwiftUI

struct FastTimerView: View {
    var viewModel: TimersViewModelREAL
    let minutes: Int
    let name: String
    var onTap: () -> Void
    
    var body: some View {
        VStack {
            Text("\(minutes):00")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.appBlue)
            Text(name)
                .font(.system(size: 13))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 2)
        }
        .frame(width: 109, height: 94)
        .background(.appGray)
        .cornerRadius(8)
        .onTapGesture {
            viewModel.addTimer(timerName: name, hours: 0, minutes: Int(minutes), seconds:0 )
            onTap()
        }
    }
}


