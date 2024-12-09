//
//  Model.swift
//  MyPortfolio
//
//  Created by Giorgi Amiranashvili on 07.12.24.
//

import Foundation

struct Experiance: Identifiable, Codable {
    var id = UUID()
    let companyName: String
    let role: String
    let duration: String
}
