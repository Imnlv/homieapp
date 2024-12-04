//
//  OnboardingView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .frame(height: 320)
                .padding(.bottom, 20)
            
            Text(data.title)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)
                .multilineTextAlignment(.center)
            
            Text(data.description)
                .fontWeight(.regular)
                .foregroundColor(.white)
                .padding(.top, 10)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}
