//
//  SettingsView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 03.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // Хранит состояние темы

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Тема")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .onChange(of: isDarkMode) { _ in
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                    }
                }
                
                Section(header: Text("Данные")) {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text("1.0.0")
                    }
                    HStack {
                        Text("Разработчик")
                        Spacer()
                        Text("ADC Hub")
                    }
                }
            }
            .navigationBarTitle("Настройки", displayMode: .inline)
        }
    }
}
