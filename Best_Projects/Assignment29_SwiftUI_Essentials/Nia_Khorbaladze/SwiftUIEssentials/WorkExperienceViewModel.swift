//
//  WorkExperienceViewModel.swift
//  SwiftUIEssentials
//
//  Created by Nkhorbaladze on 09.12.24.
//
import SwiftUI

class WorkExperienceViewModel: ObservableObject {
    @Published var workExperiences: [WorkExperience] = [
        WorkExperience(company: "HDR Solutions Inc.", role: "iOS Developer", duration: "2021 - Present")
    ]
    
    @Published var company: String = ""
    @Published var role: String = ""
    @Published var duration: String = ""
    
    func addNewExperience() {
        guard !company.isEmpty, !role.isEmpty, !duration.isEmpty else { return }
        
        let newExperience = WorkExperience(company: company, role: role, duration: duration)
        workExperiences.append(newExperience)
        
        company = ""
        role = ""
        duration = ""
    }
}
