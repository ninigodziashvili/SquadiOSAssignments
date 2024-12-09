//
//  ContentView.swift
//  SwiftUIEssentials
//
//  Created by Nkhorbaladze on 09.12.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WorkExperienceViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(color: Color.black.opacity(0.3), radius:10, x: 0, y: 10)
                    
                    Image("ProfilePicture")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .padding(.top, 20)
                
                VStack(spacing: 5) {
                    Text("John Doe")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("iOS Developer | Swift Enthusiast | Tech Lover")
                        .foregroundColor(Color.gray.opacity(0.8))
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                
                Text("Work Experience")
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.workExperiences) { experience in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(experience.company)
                                .font(.headline)
                                .padding(.leading, 4)
                            Text(experience.role)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            Text(experience.duration)
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                        .padding()
                        .frame(height: 140)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(30)
                    }
                }
                .padding(.bottom, 10)
                
                VStack(spacing: 8) {
                    Text("Add New Working Experience:")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    self.inputField(title: "COMPANY", placeholder: "Enter Company Name", text: $viewModel.company)
                    self.inputField(title: "ROLE", placeholder: "Enter Role", text: $viewModel.role)
                    self.inputField(title: "DURATION", placeholder: "Enter Duration", text: $viewModel.duration)
                    
                    Button("Add Experience") {
                        viewModel.addNewExperience()
                    }
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "3B775B"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(30)
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(viewModel: WorkExperienceViewModel())
}
