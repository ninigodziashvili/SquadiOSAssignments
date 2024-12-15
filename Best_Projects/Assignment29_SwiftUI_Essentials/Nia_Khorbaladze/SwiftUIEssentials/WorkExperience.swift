//
//  WorkExperience.swift
//  SwiftUIEssentials
//
//  Created by Nkhorbaladze on 09.12.24.
//

import Foundation

struct WorkExperience: Identifiable {
    var id = UUID()
    let company: String
    let role: String
    let duration: String
}
