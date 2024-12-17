//
//  Formaters.swift
//  Assignment30
//
//  Created by Giorgi on 16.12.24.
//

import SwiftUI

//MARK: DATA FORMATTERS
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

func formatDuration(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

func groupTimersByDay(_ timeDict: [Date: Int]) -> [Date: [(Date, Int)]] {
    let calendar = Calendar.current
    
    var groupedData: [Date: [(Date, Int)]] = [:]
    
    for (date, value) in timeDict {
        let dayStart = calendar.startOfDay(for: date)
        if groupedData[dayStart] == nil {
            groupedData[dayStart] = []
        }
        groupedData[dayStart]?.append((date, value))
    }
    
    return groupedData
}
//MARK: toolbar appearence styleing
func setNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.appGray
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}
//MARK: random array for fast timers
var fastTimerArr: [(minutes: Int, name: String)] = [
    (10, "სასხვადასხვა შეკრება"),
    (15, "ფიტნეს ვარჯიში"),
    (7, "დაზუსტების ვარჯიში"),
    (12, "კაფე დრო"),
    (20, "სტუდირების დასასრულება"),
    (5, "მუშაობის დაყვანა"),
    (8, "ბანკინგი პრაქტიკა"),
    (30, "პროექტის განვითარება"),
    (10, "ტესტირების დრო"),
    (15, "პრეზენტაციის დაწერება"),
    (5, "პარკის სიარული"),
    (25, "კონსულტაციების დრო"),
    (15, "ბაზარულ სავარჯიშო დრო"),
    (20, "კრეატიულობა")
]

