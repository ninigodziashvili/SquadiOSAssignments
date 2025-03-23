//
//  QuickTimersViewModel.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 15.12.24.
//
import Foundation

final class QuickTimersViewModel {
    var quiickTimers: [TimerModel] = [
        TimerModel(name: "ჩაის დაყენება", timeAmount: 180),
        TimerModel(name: "HIIT ვარჯიში", timeAmount: 420),
        TimerModel(name: "კვერცხის მოხარშვა", timeAmount: 600),
        TimerModel(name: "შესვენება", timeAmount: 900),
        TimerModel(name: "ყავის პაუზა", timeAmount: 1200),
        TimerModel(name: "პომოდორო", timeAmount: 1500),
        TimerModel(name: "მედიტაცია", timeAmount: 1800),
        TimerModel(name: "ვარჯიში", timeAmount: 2700),
        TimerModel(name: "სამუშაო სესია", timeAmount: 3600)
    ]
}
