//
//  TimerView.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 11.12.24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    @State private var newTitle = ""
    @State private var newHours: Int? = nil
    @State private var newMinutes: Int? = nil
    @State private var newSeconds: Int? = nil
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("ტაიმერები")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 80, leading: 20, bottom: 0, trailing: 0))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                    
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 10))
                    }
                    .padding(.trailing, 20)
                }
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.timers) { timer in
                            TimerBlockView(timer: timer)
                                .padding(.horizontal)
                                .onTapGesture {
                                    viewModel.selectTimer(timer)
                                }
                        }
                    }
                    .padding(.top, 20)
                }
                .background(Color(red: 29/255, green: 29/255, blue: 29/255))
                
                VStack {
                    TextField("", text: $newTitle, prompt:
                                Text("ტაიმერის სახელი...").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                    )
                    .padding(14)
                    .background(Color(red: 58/255, green: 58/255, blue: 58/255))
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    
                    HStack {
                        timerInputField(value: $newHours, placeholder: "სთ")
                        timerInputField(value: $newMinutes, placeholder: "წთ")
                        timerInputField(value: $newSeconds, placeholder: "წმ")
                    }
                    
                    Button(action: {
                        if !newTitle.isEmpty {
                            viewModel.addTimer(title: newTitle, hours: newHours ?? 0, minutes: newMinutes ?? 0, seconds: newSeconds ?? 0)
                            resetInputs()
                        }
                    }) {
                        Text("დამატება")
                            .padding(EdgeInsets(top: 12, leading: 40, bottom: 12, trailing: 40))
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(Color(red: 44/255, green: 44/255, blue: 44/255))
            .ignoresSafeArea()
            .blur(radius: isSheetPresented ? 5 : 0)
            .environmentObject(viewModel)
            .sheet(isPresented: $isSheetPresented) {
                BottomSheetView(onTimerSelect: { name, hours, minutes, seconds in
                    viewModel.addTimer(title: name, hours: hours, minutes: minutes, seconds: seconds)
                }, isSheetPresented: $isSheetPresented)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
                    .background(Color.clear)
            }
        }
    }
    
    private func resetInputs() {
        newTitle = ""
        newHours = nil
        newMinutes = nil
        newSeconds = nil
    }
}

private func timerInputField(value: Binding<Int?>, placeholder: String) -> some View {
    TextField("", value: value, format: .number, prompt:
                Text(placeholder).foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255)))
    .padding(12)
    .background(Color(red: 58/255, green: 58/255, blue: 58/255))
    .cornerRadius(10)
    .foregroundColor(.white)
}



#Preview {
    TimerView()
}
