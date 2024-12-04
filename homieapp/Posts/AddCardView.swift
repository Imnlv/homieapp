//
//  AddCardView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 02.12.2024.
//

import SwiftUI

struct AddCardView: View {
    @Binding var cards: [Card]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    @State private var authorName: String = ""
    @State private var authorUsername: String = ""
    @State private var backgroundImage: UIImage? = nil
    @State private var authorImage: UIImage? = nil
    @State private var productLinks: [ProductLink] = []
    @State private var newProductName: String = ""
    @State private var newProductURL: String = ""
    @Environment(\.presentationMode) var presentationMode

    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Главное")) {
                    TextField("Название", text: $title)
                    TextField("Описание", text: $description)
                    TextField("Теги (через запятую)", text: $tags)
                }

                Section(header: Text("Об авторе")) {
                    TextField("Имя", text: $authorName)
                    TextField("Никнейм", text: $authorUsername)
                }

                Section(header: Text("Фото интерьера")) {
                    Button("Добавить фото") {
                        showImagePicker = true
                    }
                    if let backgroundImage = backgroundImage {
                        Image(uiImage: backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 650)
                            .cornerRadius(15)
                            .clipped()
                    }
                }

                Section(header: Text("Ссылки на товары")) {
                    ForEach(productLinks) { product in
                        VStack(alignment: .leading) {
                            Text("Название: \(product.productName)")
                            Text("Ссылка: \(product.productURL)")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    if let url = URL(string: product.productURL) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                        }
                        .padding()
                    }

                    HStack {
                        TextField("Название товара", text: $newProductName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Ссылка", text: $newProductURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button(action: {
                            if productLinks.count < 5 {
                                let newProduct = ProductLink(productName: newProductName, productURL: newProductURL)
                                productLinks.append(newProduct)
                                newProductName = ""
                                newProductURL = ""
                            }
                        }) {
                            Text("+")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }
                }

                Button("Создать карточку") {
                    let tagList = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

                    let newCard = Card(
                        title: title,
                        description: description,
                        tags: tagList,
                        backgroundImage: backgroundImage,
                        authorImage: authorImage,
                        authorName: authorName,
                        authorUsername: authorUsername,
                        productLinks: productLinks
                    )
                    cards.append(newCard)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                SimpleImagePicker(selectedImage: $backgroundImage)
            }
            .navigationBarTitle("Создание карточки")
            .navigationBarItems(trailing: Button("Закрыть") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
