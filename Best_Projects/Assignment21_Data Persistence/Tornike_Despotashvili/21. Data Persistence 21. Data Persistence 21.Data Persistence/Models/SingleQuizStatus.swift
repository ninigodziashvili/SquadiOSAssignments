//
//  SingleQuizStatus.swift
//  21. Data Persistence 21. Data Persistence 21.Data Persistence
//
//  Created by Despo on 04.11.24.
//
import Foundation

struct SingleQuizStatus: Codable {
    let isAnswered: Bool
    let prevAnswer: String
}
