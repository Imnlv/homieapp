//
//  OnboardingContainerView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import SwiftUI

struct OnboardingContainerView: View {
    let pages = [
        OnboardingData(image: "img1", title: "Находите \nвдохновение", description: "Исследуйте подборки и коллекции \nдругих авторов, сохраняйте \nих и вдохновляйтесь"),
        OnboardingData(image: "img2", title: "Быстрый \nпоиск товаров", description: "Теперь не нужно искать товары \nс картинок самим — все \nесть в подборках"),
        OnboardingData(image: "img3", title: "И главное — \nсохраняйте", description: "Нарабатывайте насмотренность \nи развивайтесь при помощи работ \nдругих авторов")
    ]
    
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count) { index in
                    OnboardingView(data: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            // Кнопки навигации
            HStack {
                if currentPage > 0 {
                    Button("Назад") {
                        withAnimation {
                            currentPage -= 1
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                }
                Spacer()
                if currentPage < pages.count - 1 {
                    Button("Далее") {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 120, height: 20)
                    .padding()
                    .background(Color("ButtonBackground"))
                    .cornerRadius(40)
                } else {
                    Button("Начать") {
                        hasSeenOnboarding = true
                    }
                    .foregroundColor(.black)
                    .frame(width: 120, height: 20)
                    .padding()
                    .background(Color("ButtonBackground"))
                    .cornerRadius(40)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 0)
        }
        .background(Color.background)
    }
}
