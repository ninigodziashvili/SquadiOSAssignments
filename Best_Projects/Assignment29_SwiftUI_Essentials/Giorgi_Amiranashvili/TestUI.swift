//
//  TestUI.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 08.12.24.
//

import SwiftUI

struct TestUI: View {
    var body: some View {
        
        @State var experienceArray: [Experiance] =
        [
            Experiance(companyName: "HDR Solutions Inc.", role: "iOS Developer", duration: "2021 - Present"),
            Experiance(companyName: "EvosdasxasxajkdZs", role: "Game Developer", duration: "2015 - 2019")
            
        ]

        ScrollView {
            VStack(alignment: .leading) {
                ForEach(experienceArray, id: \.id) {result in
                    Text("\(result.companyName)")
                        .font(Font.system(size: 17)).bold()
                        .padding(.leading, 20)
                        .padding(.bottom, 6)
                        .padding(.top, 25)
                        .background(.blue)
                        
                    Text("\(result.role)")
                        .padding(.leading, 14)
                        .font(Font.system(size: 15))
                        .foregroundStyle(.experienceLabel)
                        .padding(.bottom, 5)
                    
                    Text("\(result.duration)")
                        .padding(.leading, 14)
                        .font(Font.system(size: 15))
                        .foregroundStyle(.experienceLabel)
                }
            }
        }
    }
}

#Preview {
    TestUI()
}
