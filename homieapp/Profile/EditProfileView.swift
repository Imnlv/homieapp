//
//  EditProfileView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 03.12.2024.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var user: UserProfile
    @Binding var selectedImage: UIImage?
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var showImagePicker = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Avatar")) {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else if let avatar = user.avatar {
                            Image(uiImage: avatar)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                    }
                }
                
                Section(header: Text("Персональная информация")) {
                    TextField("Имя", text: $firstName)
                    TextField("Фамилия", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
            }
            .navigationBarTitle("Изменить профиль")
            .navigationBarItems(
                leading: Button("Закрыть") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Сохранить") {
                    user.firstName = firstName
                    user.lastName = lastName
                    user.email = email
                    if let selectedImage = selectedImage {
                        user.avatar = selectedImage
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                firstName = user.firstName
                lastName = user.lastName
                email = user.email
                selectedImage = user.avatar
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}
