//
//  MyApp.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("isAuthenticated") private var isAuthenticated = false 
    var body: some Scene {
        WindowGroup {
            if !hasSeenOnboarding {
                OnboardingContainerView()
            } else if !isAuthenticated {
                LoginView()
            } else {
                ContentView()
            }
        }
    }
}
