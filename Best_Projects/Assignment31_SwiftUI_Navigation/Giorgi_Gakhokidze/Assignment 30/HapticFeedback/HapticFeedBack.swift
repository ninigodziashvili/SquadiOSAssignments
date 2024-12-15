//
//  HapticFeedBack.swift
//  Assignment 30
//
//  Created by Giorgi Gakhokidze on 11.12.24.
//
import CoreHaptics
import Foundation

class HapticFeedBack {
    static let shared = HapticFeedBack()
    
    var haptic: CHHapticEngine?
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            haptic = try CHHapticEngine()
            try haptic?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func complexSuccess() {
        prepareHaptics()
        print("starting")
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try haptic?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            print("done")
        } catch {
            print(error.localizedDescription)
        }
    }
}
