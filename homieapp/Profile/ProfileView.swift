//
//  ProfileView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 03.12.2024.
//

import SwiftUI

struct ProfileView: View {
    @Binding var user: UserProfile
    @State private var isEditing = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
               
                if let avatar = user.avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                Text(user.email)
                    .font(.subheadline)
                    .padding(.top, 5)
                
                Spacer()
                
                
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text("Редактировать")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(20)
                }
                .sheet(isPresented: $isEditing) {
                    EditProfileView(user: $user, selectedImage: $selectedImage)
                }
            }
            .padding()
            .navigationBarTitle("Профиль", displayMode: .inline)
        }
    }
}
