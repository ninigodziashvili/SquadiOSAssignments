//
//  TimerViewModel.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//
import Foundation
import SwiftUI

final class TimerViewModel: ObservableObject {
    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
        case completed
    }
    
    var name: String = ""
    private var timer: Timer?
    private(set) var timerModel: TimerModel?
    weak var parentViewModel: TimerListViewModel?
    
    private let logger = DependencyContainer.shared.resolve(type: .closureBased, for: LogTimerUseCase.self)
    
    private var totalTimeForCurrentSelection: Int {
        guard let timerModel = timerModel else { return 0 }
        return timerModel.timeAmount
    }
    
    @Published var timeAmount = 0
    @Published var secondsToCompletion = 0
    @Published var state: TimerState = .cancelled {
        didSet {
            switch state {
            case .active:
                startTimer()
                secondsToCompletion = timeAmount
            case .paused:
                timer?.invalidate()
            case .resumed:
                startTimer()
            case .cancelled:
                timerModel?.logUseHistory(useTimeInSeconds: timeAmount - secondsToCompletion)
                logUse(timer: timerModel)
                invalidateTimer()
                secondsToCompletion = timeAmount
            case .completed:
                timerModel?.logUseHistory(useTimeInSeconds: timeAmount)
                logUse(timer: timerModel)
                invalidateTimer()
                secondsToCompletion = timeAmount
                HapticsManager.shared.complexSuccess() 
            }
        }
    }
    
    init(timer: TimerModel, parentViewModel: TimerListViewModel) {
        self.timerModel = timer
        self.name = timer.name
        self.timeAmount = timer.timeAmount
        self.secondsToCompletion = timer.timeAmount - timer.timePassed
        self.parentViewModel = parentViewModel
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.secondsToCompletion -= 1
            
            if self.secondsToCompletion <= 0 {
                self.state = .completed
            }
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func logUse(timer: TimerModel?) {
        guard let timer = timer else { return }
        logger.execute(timer)
    }
    
    func deleteTimer() {
        guard let timerModel = timerModel else { return }
        invalidateTimer()
        parentViewModel?.removeTimer(timerModel)
    }
}

