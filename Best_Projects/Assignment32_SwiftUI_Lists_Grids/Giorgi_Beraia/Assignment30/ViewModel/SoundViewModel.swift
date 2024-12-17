//
//  SoundViewModel.swift
//  Assignment30
//
//  Created by Giorgi on 11.12.24.
//

import SwiftUI
import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?

    func playSound(named soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
    }
}

