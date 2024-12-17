//
//  TimerView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel: TimerViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    init(timer: TimerModel, parentViewModel: TimerListViewModel) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(timer: timer, parentViewModel: parentViewModel))
    }
    
    var body: some View {
        ZStack {
            VStack() {
                HStack(alignment: .firstTextBaseline) {
                    Text(viewModel.name)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.white)
                    Spacer()
                    Button(action: {
                        viewModel.deleteTimer()
                    }) {
                        Image("customBin")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.leading, 15)
                Text(viewModel.secondsToCompletion.asTimes)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color("customBlue"))
                HStack(spacing: 15) {
                    switch viewModel.state {
                    case .active:
                        customButton(color: Color("customOrange"), title: "პაუზა", padding: 10) {
                            viewModel.state = .paused
                        }
                        customButton(color: Color("customRed"), title: "გადატვირთვა", padding: 10) {
                            viewModel.state = .cancelled
                        }
                    case .paused:
                        customButton(color: Color("customGreen"), title: "გაგრძელება", padding: 10) {
                            viewModel.state = .resumed
                        }
                        customButton(color: Color("customRed"), title: "გადატვირთვა", padding: 10) {
                            viewModel.state = .cancelled
                        }
                    case .resumed:
                        customButton(color: Color("customOrange"), title: "პაუზა", padding: 10) {
                            viewModel.state = .paused
                        }
                        customButton(color: Color("customRed"), title: "გადატვირთვა", padding: 10) {
                            viewModel.state = .cancelled
                        }
                    case .cancelled:
                        customButton(color: Color("customGreen"), title: "დაწყება", padding: 10) {
                            viewModel.state = .active
                        }
                    case .completed:
                        customButton(color: Color("customGreen"), title: "დაწყება", padding: 10) {
                            viewModel.state = .active
                        }
                    }
                }
            }
            .padding([.top, .bottom], 10)
        }
        .frame(height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .background(Color("customGray"))
        .cornerRadius(15)
        .padding([.top, .trailing, .leading], 15)
        .onTapGesture {
            coordinator.push(.TimerDetails, timer: viewModel.timerModel)
        }
    }
}
