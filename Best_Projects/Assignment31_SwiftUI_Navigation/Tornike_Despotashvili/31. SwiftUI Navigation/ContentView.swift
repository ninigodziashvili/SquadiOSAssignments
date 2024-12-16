//
//  ContentView.swift
//  31. SwiftUI Navigation
//
//  Created by Despo on 13.12.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var name = ""
    @State var hours = ""
    @State var minutes = ""
    @State var seconds = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 15) {
                
                HStack {
                    Text("ტაიმერები")
                        .styledText(.white, 24, .bold)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
                .padding(.horizontal, 15)
                .background(.cardCol)
                
                VStack(spacing: 50) {
                    ScrollView {
                        VStack {
                            ForEach($viewModel.timersArray) { $timer in
                                NavigationLink(destination: DetailsView(timer: timer)) {
                                    CardView(timer: $timer)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    VStack(spacing: 15) {
                        TextField("", text: $name, prompt: Text("ტაიმერის სახელი...").foregroundColor(.boulder))
                            .styledField()
                            .onChange(of: name) {newValue, oldValue in
                                name = newValue
                            }
                        
                        HStack(spacing: 10) {
                            TextField("", text: $hours, prompt: Text("სთ").foregroundColor(.boulder))
                                .styledField()
                                .onChange(of: hours) {newValue, oldValue in
                                    hours = newValue
                                }
                            
                            TextField("", text: $minutes, prompt: Text("წთ").foregroundColor(.boulder))
                                .styledField()
                                .onChange(of: minutes) {newValue, oldValue in
                                    minutes = newValue
                                }
                            
                            TextField("", text: $seconds, prompt: Text("წმ").foregroundColor(.boulder))
                                .styledField()
                                .onChange(of: seconds) {newValue, oldValue in
                                    seconds = newValue
                                }
                        }
                        
                        Button("დამატება") {
                            viewModel.addTimer(
                                name: name,
                                hh: hours,
                                mm: minutes,
                                ss: seconds
                            )
                            
                            name = ""
                            hours = ""
                            minutes = ""
                            seconds = ""
                        }
                        .foregroundStyle(.white)
                        .frame(width: 155, height: 42)
                        .background(.azure)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxHeight: 130)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 15)
                .environmentObject(viewModel)
            }
            .background(.primaryCol)
        }
        .navigationBarHidden(true)
    }
}

struct CardView: View {
    @Binding var timer: TimerModel
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(timer.name)
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                
                Spacer()
                
                Button(action: {
                    viewModel.removeTimer(for: timer)
                }) {
                    Image("bin")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            
            HStack {
                Text(timer.formatTime(from: timer.duration))
                    .styledText(.azure, 36, .bold)
            }
            
            HStack {
                Button {
                    if timer.isStarted {
                        viewModel.stopTimer(for: timer)
                    } else {
                        viewModel.startTimer(for: timer)
                    }
                } label: {
                    Text(timer.isStarted ? "პაუზა" : timer.isPaused ? "გაგრძელება" : "დაწყება")
                }
                .timerButtonStyles(bgColor: timer.isStarted ? .pizzaz : timer.duration == 0 ? .gray : .emerlad)
                .disabled(timer.duration == 0)
                
                
                Button {
                    viewModel.resetTimer(for: timer)
                } label: {
                    Text("გადატვირთვა")
                }
                .timerButtonStyles(bgColor: .red)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.cardCol)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
}
