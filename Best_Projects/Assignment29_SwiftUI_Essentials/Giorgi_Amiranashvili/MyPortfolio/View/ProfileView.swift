//
//  ProfileView.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 07.12.24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 102, height: 102)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(.white, lineWidth: 8)
                        .shadow(radius: 3, y: 5)
                )
                .padding(.bottom, 17)
            
            Text("John Doe")
                .font(Font.system(size: 24)).bold()
                .padding(.bottom, 13)
            
            Text("IOS Development | Swift Enthusiast | Tech Lover")
                .font(Font.system(size: 15)).bold()
                .foregroundStyle(.biocolor)
        }
        .padding(.bottom, 23)
    }
}

