//
//  MealWiseApp.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import SwiftUI

@main
struct MealWiseApp: App {
    
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenState)
        }
    }
}
