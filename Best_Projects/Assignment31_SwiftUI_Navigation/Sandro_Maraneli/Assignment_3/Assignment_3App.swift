//
//  Assignment_3App.swift
//  Assignment_3
//
//  Created by Sandro Maraneli on 11.12.24.
//

import SwiftUI

@main
struct Assignment_3App: App {
    @StateObject private var viewModel = TimerViewModel()
       
       var body: some Scene {
           WindowGroup {
               TimerView()
                   .environmentObject(viewModel)
           }
       }
}
