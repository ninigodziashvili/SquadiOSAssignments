//
//  AppFlowCoordinator.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import SwiftUI

enum Page: String, Identifiable {
    case TimerList
    case TimerDetails
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case QickTimers
    
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    private var timer: TimerModel?
    private var timerViewModel: TimerListViewModel?
    
    func push(_ page: Page, timer: TimerModel? = nil) {
        self.timer = timer
        path.append(page)
    }
    
    func present(sheet: Sheet, timerViewModel: TimerListViewModel? = nil) {
        self.sheet = sheet
        self.timerViewModel = timerViewModel
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .TimerList:
            TimerListView()
        case .TimerDetails:
            if let timer {
                TimerDetailView(timer: timer)
            } else {
                fatalError("you must provide timerModel")
            }
        }
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .QickTimers:
            if let timerViewModel {
                QuickTimersView(parentViewModel: timerViewModel)
                    .presentationDetents([.fraction(0.5)])
            } else {
                fatalError("you must provide parent viewmodel when presenting sheet")
            }
        }
    }
}
