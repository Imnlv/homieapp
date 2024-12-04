//
//  CardView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 02.12.2024.
//

import SwiftUI

struct CardView: View {
    var card: Card

    var body: some View {
        ZStack {
            if let backgroundImage = card.backgroundImage {
                Image(uiImage: backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 400, maxHeight: 650)
                    .cornerRadius(25)
                    .clipped()
            } else {
                Color.gray.opacity(0.2)
                    .cornerRadius(25)
                    .clipped()
            }

            VStack {
                HStack {
                    if let authorImage = card.authorImage {
                        Image(uiImage: authorImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .offset(x: -5)
                    } else {
                        Image("personImage")
                            .font(.title)
                            .foregroundColor(.gray)
                            .offset(x: -5)
                    }

                    VStack(alignment: .leading) {
                        Text(card.authorName)
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 21)

                        Text("@\(card.authorUsername)")
                            .font(.system(size: 9))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 7)

                    Spacer()
                }
                .padding()
                .frame(width: 160, height: 60)
                .background(.gray.opacity(0.6))
                .cornerRadius(10)
                .padding(.top, 20)

                Spacer()

                HStack {
                    // Кнопки лайка и коммент
                }
                .padding()
                .frame(width: 150, height: 60)
                .background(.gray.opacity(0.6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            }
        }
        .frame(width: 370, height: 650)
        .cornerRadius(25)
        .clipped()
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(
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
