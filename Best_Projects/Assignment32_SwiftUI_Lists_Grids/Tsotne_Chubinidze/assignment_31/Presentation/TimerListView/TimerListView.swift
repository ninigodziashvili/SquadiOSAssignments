//
//  TimerListView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import SwiftUI

struct TimerListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = TimerListViewModel()
    @State var name: String = ""
    @State var hour: String = ""
    @State var minute: String = ""
    @State var second: String = ""
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack() {
                    headerView(title: "ტაიმერები")
                    HStack {
                        Spacer()
                        Button {
                            coordinator.present(sheet: .QickTimers, timerViewModel: viewModel)
                        } label: {
                            Image("customPlus")
                        }
                        .padding([.trailing, .bottom])
                    }
                }
                 
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.timers.reversed()) { timer in
                            TimerView(timer: timer, parentViewModel: viewModel)
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    customTextField(placeholder: "ტაიმერის სახელი", text: $name)
                        .padding(.top, 10)
                    
                    HStack(spacing: 10) {
                        customTextField(placeholder: "სთ", text: $hour)
                        customTextField(placeholder: "წთ", text: $minute)
                        customTextField(placeholder: "წმ", text: $second)
                    }
                    
                    customButton(color: Color("customBlue"), title: "დამატება", padding: 25) {
                        addTimer()
                    }
                }
                .formLayout(padding: 10)
            }
        }
        .background(Color("customBlack"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Fields Cant Be Empthy"), message: Text("Please fill all fields."), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            viewModel.getTimers()
        }
    }
    
    private func addTimer() {
        if !viewModel.validateInput(hour: hour, minute: minute, second: second) {
            showAlert = true
            return
        }
        
        let hourInt = Int(hour) ?? 0
        let minuteInt = Int(minute) ?? 0
        let secondInt = Int(second) ?? 0
        let totalTimeInSeconds = (hourInt * 3600) + (minuteInt * 60) + secondInt
        
        let timer = TimerModel(name: name, timeAmount: totalTimeInSeconds)
        viewModel.addTimer(timer)
        
        name = ""
        hour = ""
        minute = ""
        second = ""
    }
}

#Preview(body: {
    TimerListView()
})


