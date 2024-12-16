//
//  TimerDetailsView.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 13.12.24.
//

import SwiftUI

struct TimerDetailsView: View {
    @ObservedObject var timer: TimerModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 29/255, green: 29/255, blue: 29/255)
                .ignoresSafeArea()
            VStack {
                Text(timer.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 65)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                
                VStack {
                    
                    VStack {
                        Image(systemName: "timer")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                            .padding(.top, 50)
                        
                        Text("ხანგრძლივობა")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("\(String(format: "%02d", timer.originalHours)):\(String(format: "%02d", timer.originalMinutes)):\(String(format: "%02d", timer.originalSeconds))")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(.bottom, 50)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .cornerRadius(10)
                    
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 10) {
                            Text("აქტივობის ისტორია")
                                .foregroundColor(.white)
                                .frame(maxWidth:.infinity,alignment: .leading)
                                .font(.system(size: 18))
                            
                            Divider()
                                .background(Color.white)
                                .frame(height: 2)
                                .padding(.vertical, 5)
                            
                            HStack {
                                Text("თარიღი")
                                Spacer()
                                Text("დრო")
                            }
                            .foregroundColor(.white)
                            .padding()
                            
                            ForEach(timer.usageHistory, id: \.timestamp) { usage in
                                HStack {
                                    Text(dateFormatter(date: usage.timestamp))
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(usage.duration)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                    .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                    .cornerRadius(10)
                }
                .background(Color(red: 29/255, green: 29/255, blue: 29/255))
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ka_GE")
        formatter.dateFormat = "dd MMM yyyy"
        
        return formatter.string(from: date)
    }
}
