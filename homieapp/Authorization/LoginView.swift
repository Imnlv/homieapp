//
//  LoginView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @AppStorage("isAuthenticated") private var isAuthenticated = false

    var body: some View {
        VStack {
            
            Image("BackImage")
                .ignoresSafeArea()
                .scaledToFit()
                .padding(.top, -30)

            Text("Вход")
                .font(.largeTitle)
                .padding(.bottom, 40)
                .fontWeight(.bold)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 300)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 300)
            
            Button(action: {
                if username == "Test" && password == "password" {
                    isAuthenticated = true
                } else {
                    showError = true
                }
            }) {
                Text("Войти")
                    .foregroundColor(Color("ButtonBackground"))
                    .frame(width: 120, height: 20)
                    .padding()
                    .background(Color("Background"))
                    .cornerRadius(40)
            }
            .padding()
            .alert(isPresented: $showError) {
                Alert(title: Text("Login Failed"), message: Text("Incorrect username or password"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}
