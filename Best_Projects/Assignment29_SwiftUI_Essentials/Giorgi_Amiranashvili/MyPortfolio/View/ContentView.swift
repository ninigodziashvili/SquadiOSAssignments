//
//  ContentView.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 07.12.24.
//

import SwiftUI

struct ContentView: View {
    @State var companyName: String = ""
    @State var role: String = ""
    @State var duration: String = ""
    @State var experienceArray: [Experiance] =
    [
        Experiance(companyName: "HDR  Solutions Inc.", role: "iOS Developer", duration: "2021 - Present"),
    ]
    
    @AppStorage("ExperiencesData") var experiences: Data?
    
    let viewModel = PortfolioViewModel()
    
    var body: some View {
        VStack {
            
            ProfileView()
            
            Text("Work Experience")
                .padding(.trailing, 165)
                .padding(.bottom, 23)
                .font(Font.system(size: 20)).bold()
            
            if !experienceArray.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(experienceArray, id: \.id) {result in
                            Text("\(result.companyName)")
                                .font(Font.system(size: 17)).bold()
                                .padding(.leading, 20)
                                .padding(.bottom, 6)
                                .padding(.top, 25)
                            
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
                .frame(width: 351, height: 140)
                .background(Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255, opacity: 0.5333)
                    .cornerRadius(24)
                )
                .padding(.bottom, 23)
            }
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Add New Working Experience")
                        .font(Font.system(size: 17)).bold()
                        .padding(.leading, 24)
                        .padding(.bottom, 8)
                        .disableAutocorrection(true)
            
                    VStack(alignment: .leading) {
                        Text("COMPANY")
                            .textStyle()
                        
                        TextField("Enter Company Name", text: $companyName)
                            .texFieldStyle()
                        
                        Text("ROLE")
                            .textStyle()
                        
                        TextField("Enter Role", text: $role)
                            .texFieldStyle()
                        
                        Text("DURATION")
                            .textStyle()
                        
                        TextField("Enter Duration", text: $duration)
                            .texFieldStyle()
                    }
                    .padding(.leading, 32.26)
                    
                    VStack(alignment: .trailing){
                        Button("Add new Experiance") {
                            let currentExperience = Experiance(companyName: companyName, role: role, duration: duration)
                            experienceArray.append(currentExperience)
                            experiences = viewModel.modifyToData(experienceArray)
                            companyName = ""
                            role = ""
                            duration = ""
                        }
                        .frame(width: 302, height: 40)
                        .foregroundStyle(.white)
                        .background(Color(red: 59 / 255, green: 119 / 255, blue: 91 / 255))
                        .cornerRadius(10)
                    }
                    .padding(.leading, 22)
                    .padding(.top, 12)
                }
                .frame(width: 351, height: 298, alignment: .leading)
                .background(Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255, opacity: 0.5333)
                    .cornerRadius(24)
                )
            }
            .frame(maxHeight: .infinity)
        }

        .onAppear {
                        UserDefaults.standard.removeObject(forKey: "ExperiencesData")
            if let storedData = experiences,
               let decodedExperiences = viewModel.modifyFromData(storedData) {
                experienceArray = decodedExperiences
            }
        }
    }
}

extension View {
    func texFieldStyle() -> some View {
        modifier(CustomStyleModifier())
    }
}

extension View {
    func textStyle() -> some View {
        modifier(TextStyleModifier())
    }
}

#Preview {
    ContentView()
}
