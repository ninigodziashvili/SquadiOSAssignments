//
//  assignment_31App.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//

import SwiftUI

@main
struct assignment_31App: App {
    
    init() {
        AppConfigurer.configureDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}
