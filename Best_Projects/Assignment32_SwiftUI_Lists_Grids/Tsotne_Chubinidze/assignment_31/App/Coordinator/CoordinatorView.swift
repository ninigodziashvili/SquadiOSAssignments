//
//  CoordinatorView.swift
//  assignment_31
//
//  Created by Cotne Chubinidze on 13.12.24.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .TimerList)
                    .navigationDestination(for: Page.self) { page in
                        coordinator.build(page: page)
                            .navigationBarBackButtonHidden(true)
                    }
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.build(sheet: sheet)
                    }
            }
            .environmentObject(coordinator)
            
            if coordinator.sheet != nil {
                Color.clear
                    .background(.white.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    CoordinatorView()
}

