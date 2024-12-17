//
//  ტემპ.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 16.12.24.
//
import SwiftUI

struct TitleView: View {
    let timer: TimerModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image("customClock")
                    .resizable()
                    .frame(width: 44, height: 44)
                Text("ხანგრძლივობა")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.white)
                Text(timer.timeAmount.asTimes)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color("customBlue"))
            }
                .padding(20)
                .frame(maxWidth: .infinity)
        }
        .background(Color("customGray"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.bottom, 10)
    }
}
