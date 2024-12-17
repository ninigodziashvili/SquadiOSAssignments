//
//  BottomSheetView.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 15.12.24.
//

import SwiftUI

struct BottomSheetView: View {
    let timers = [
        ("ყოველდღიური ვარჯიში", 1, 30, 45),
        ("კოდის წერა", 0, 45, 30),
        ("დასვენება", 2, 10, 15),
        ("ძილი", 0, 5, 10),
        ("კვება", 3, 25, 50),
        ("გართობა", 1, 20, 0),
        ("დალაგება", 0, 10, 20),
        ("სწავლა", 4, 0, 0),
        ("სპორტი", 0, 59, 59),
        ("ტელევიზორის ყურება", 1, 10, 30)
    ]

    
    var onTimerSelect: (String, Int, Int, Int) -> Void
    @Binding var isSheetPresented: Bool
    
    func formatDuration(hours: Int, minutes: Int, seconds: Int) -> String {
        String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("სწრაფი ტაიმერები")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity, alignment: .leading)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(timers, id: \.0) { timer in
                        VStack {
                            Text(formatDuration(hours: timer.1, minutes: timer.2, seconds: timer.3))
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding(.bottom, 5)
                            
                            Text(timer.0)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color(red: 44/255, green: 44/255, blue: 44/255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onTapGesture {
                            onTimerSelect(timer.0, timer.1, timer.2, timer.3)
                            isSheetPresented = false
                        }
                    }
                }
                .padding(.top, 20)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 29/255, green: 29/255, blue: 29/255))
    }
}


