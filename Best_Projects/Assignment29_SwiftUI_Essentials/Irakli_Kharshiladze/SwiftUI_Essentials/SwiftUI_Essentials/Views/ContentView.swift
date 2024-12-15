//
//  ContentView.swift
//  SwiftUI_Essentials
//
//  Created by irakli kharshiladze on 08.12.24.
//

import SwiftUI

struct ContentView: View {
    private let occupations: [String] = ["iOS Developer", "Swift Enthusiast", "Tech Lover"]
    @State private var experiences = [Experience(company: "HDR Solutions Inc.", role: "iOS Developer", duration: "2021 - present")]
    @State private var company: String = ""
    @State private var role: String = ""
    @State private var duration: String = ""
    
    private var isFormValid: Bool {
        return !company.isEmpty && !role.isEmpty && !duration.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 15) {
                    Image("cat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.tint)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 7)
                        )
                        .shadow(radius: 5)
                    Text("John Doe")
                        .font(.system(size: 24, weight: .semibold))
                    HStack {
                        ForEach(occupations.indices, id: \.self) { index in
                            Text(occupations[index])
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.textcolor)
                            if index != occupations.count - 1 {
                                Text("|")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(Color.textcolor)
                            }
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Work Experience")
                        .customTitle(size: 20)
                        .padding(.leading, 20)
                    ScrollView() {
                        LazyVStack(alignment: .leading, spacing: 15) {
                            ForEach(experiences, id: \.id) { experience in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(experience.company)
                                        .customTitle(size: 17)
                                        .padding(.leading, 5)
                                    Text(experience.role)
                                        .customText(size: 15)
                                    Text(experience.duration)
                                        .customText(size: 15)
                                }
                                .frame( maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 29, leading: 14, bottom: 33, trailing: 0))
                                .background(Color.cardBackground)
                                .cornerRadius(24)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .frame(height: 150)
                }
                VStack (alignment: .leading, spacing: 15) {
                    Text("Add New Working Experience:")
                        .customTitle(size: 17)
                    VStack (alignment: .leading, spacing: 10) {
                        LabeledTextField(label: "Company", placeholder: "Enter Company Name", text: $company)
                        LabeledTextField(label: "Role", placeholder: "Enter Role", text: $role)
                        LabeledTextField(label: "Duration", placeholder: "Enter Duration", text: $duration)
                    }
                    .padding(.horizontal, 10)
                    Button("Add Experience") {
                        experiences.append(Experience(company: company, role: role, duration: duration))
                        company = ""
                        role = ""
                        duration = ""
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background( isFormValid ? Color.buttonGreen : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(isFormValid ? false : true)
                }
                .padding(25)
                .background(Color.cardBackground)
                .cornerRadius(24)
            }
            .padding(25)
        }
        .padding(.top, 5)
        .scrollIndicators(.hidden)
    }
}


//#Preview {
//    ContentView()
//}
