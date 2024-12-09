//
//  SwiftUIEssentialsApp.swift
//  SwiftUIEssentials
//
//  Created by Nkhorbaladze on 09.12.24.
//

import SwiftUI

@main
struct SwiftUIEssentialsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WorkExperienceViewModel())
        }
    }
}
