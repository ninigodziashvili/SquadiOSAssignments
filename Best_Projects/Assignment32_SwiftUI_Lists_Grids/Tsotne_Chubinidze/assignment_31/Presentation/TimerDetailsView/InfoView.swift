//
//  InfoView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 16.12.24.
//
import SwiftUI

struct InfoView: View {
    @StateObject private var viewModel: TimerDetailsViewModel

    init(timer: TimerModel) {
        _viewModel = StateObject(wrappedValue: TimerDetailsViewModel(timer: timer))
    }

    var body: some View {
        ZStack {
            VStack {
                infoRow(title: "დღევანდელი სესიები", value: "\(viewModel.numberOfSessions()) სესია")
                separator(thickness: 1, opacity: 0.1)
                    .padding(.bottom, 8)
                infoRow(title: "საშუალო ხანგრძლივობა", value: viewModel.averageDuration())
                separator(thickness: 1, opacity: 0.1)
                    .padding(.bottom, 8)
                infoRow(title: "ჯამური დრო", value: viewModel.totalTime())
                separator(thickness: 1, opacity: 0.1)
                    .padding(.bottom, 8)
            }
        }
        .padding([.leading, .top, .trailing])
        .background(Color("customGray"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

