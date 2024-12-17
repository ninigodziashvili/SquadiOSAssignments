//
//  ContentView.swift
//  Assignment30
//
//  Created by Giorgi on 11.12.24.
//

import SwiftUI

struct ContentView: View {
    @State private var timerName = ""
    @State private var hours = ""
    @State private var minutes = ""
    @State private var secondes = ""
    @StateObject private var viewModel = TimersViewModelREAL()
    
    @State private var hasLoadedTimers = false
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingCredits = false
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Text("ტაიმერები")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading )
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        showingCredits.toggle()
                    }) {
                        Image(.plus)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 19, height: 19)
                    }.padding(.trailing, 20)
                    .sheet(isPresented: $showingCredits) {
                        VStack {
                            Text("სწრაფი ტაიმერები")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .padding(.bottom, 21)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            ScrollView {
                                LazyVGrid(columns: [GridItem(spacing: 12), GridItem(spacing: 12), GridItem(spacing: 12),], spacing: 12) {
                                    Section {
                                        ForEach(fastTimerArr.indices, id: \.self) { index in
                                            let obj = fastTimerArr[index]
                                            FastTimerView(viewModel: viewModel, minutes: obj.minutes, name: obj.name) {
                                                showingCredits = false
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .presentationDetents([.height(300)])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.appBlack)
                    }
                }
                .frame(height: 110)
                .frame(maxWidth: .infinity)
                .background(.appGray)
                
                ScrollView{
                    ForEach(viewModel.timers) { timer in
                        NavigationLink(
                            destination: DetailsView(timer: timer)
                        ) {
                            TimerView(viewModel: viewModel, timer: timer)
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    TextField("", text: $timerName, prompt: Text("ტაიმერის სახელი...").foregroundStyle(.appPlaceHolder)
                    )
                    .padding(.horizontal, 12)
                    .foregroundStyle(.white)
                    .frame(height: 39)
                    .frame(maxWidth: .infinity)
                    .background(.appFiledGray)
                    .cornerRadius(8)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    HStack{
                        TextFiledMini(text: $hours, title: "სთ")
                        TextFiledMini(text: $minutes, title: "წთ")
                        TextFiledMini(text: $secondes, title: "წმ")
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    
                    Button("დამატება") {
                        viewModel.addTimer(timerName: timerName, hours: Int(hours) ?? 0, minutes: Int(minutes) ?? 0, seconds: Int(secondes) ?? 0)
                    }
                    .frame(width: 155, height: 42)
                    .background(.appBlue)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                }
                .frame(height: 191)
                .frame(maxWidth: .infinity)
                .background(.appGray)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.appBlack)
            .blur(radius: showingCredits ? 3 : 0)
            .onAppear{
                if !hasLoadedTimers { 
                    viewModel.loadTimers()
                    hasLoadedTimers = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

