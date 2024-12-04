//
//  CardDetailView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 02.12.2024.
//

import SwiftUI

struct CardDetailView: View {
    var card: Card
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Text(card.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                ZStack {
                    if let backgroundImage = card.backgroundImage {
                        Image(uiImage: backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 360, height: 650)
                            .cornerRadius(20)
                    } else {
                        Color.gray.opacity(0.2)
                            .cornerRadius(20)
                    }
                    
                    HStack {
                        if let authorImage = card.authorImage {
                            Image(uiImage: authorImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .offset(x: -5)
                        } else {
                            Image("personImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .offset(x: -5)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(card.authorName)
                                .font(.system(size: 13))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("@\(card.authorUsername)")
                                .font(.system(size: 9))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 8)
                        .padding(.horizontal, -3)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 160, height: 60)
                    .background(.gray.opacity(0.6))
                    .cornerRadius(10)
                    .padding(.top, -310)
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Описание")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Background"))
                        .padding(.top, 30)
                    
                    Text(card.description)
                        .font(.body)
                        .padding(20)
                        .frame(width: 370)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.top, 5)
                }
                
                Text("Теги")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Background"))
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: true){
                    HStack {
                        ForEach(card.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .frame(width: 120, height: 40)
                                .background(Color.gray.opacity(0.6))
                                .cornerRadius(30)
                        }
                    }
                    .padding(.top, 10)
                }

                if !card.productLinks.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Ссылки")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Background"))
                            .padding(.top, 30)
                        
                        ForEach(card.productLinks) { productLink in
                            HStack {
                                Text(productLink.productName)
                                Spacer()
                                Text(productLink.productURL)
                                    .foregroundColor(.black.opacity(0.6))
                                    .onTapGesture {
                                        if let url = URL(string: productLink.productURL) {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                            .padding()
                        }
                        .padding()
                        .frame(width: 370)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.top, 5)
                    }
                    .padding(.top, 7)
                }

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Закрыть")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
                .padding(.top, 50)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}



struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: Card(
            title: "Желтые тона",
            description: "Description for card 1",
            tags: ["Декор", "Аксессуары"],
            backgroundImage: UIImage(named: "backgroundImage"),
            authorImage: UIImage(named: "profilePhoto1"),
            authorName: "Anfisa",
            authorUsername: "annfissa",
            productLinks: [
                ProductLink(productName: "Товар 1", productURL: "https://example.com/product1"),
                ProductLink(productName: "Товар 2", productURL: "https://example.com/product2")
            ]
        ))
    }
}
