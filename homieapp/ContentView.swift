//
//  ContentView.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = [
        Card(
            title: "Laerie light",
            description: "Моя коллекция светильников \nот различных брендов, собранная во время выставки Laerie Light",
            tags: ["Декор", "Аксессуары", "Свет", "Casual"],
            backgroundImage: UIImage(named: "backgroundImage2"),
            authorImage: UIImage(named: "profilePhoto2"),
            authorName: "Allise",
            authorUsername: "alllllise.e",
            productLinks: [
                ProductLink(productName: "bethwalls", productURL: "https://market.yandex.ru/"),
                ProductLink(productName: "bethwalls 2", productURL: "https://market.yandex.ru/")
            ]
        ),
        Card(
            title: "Желтые тона",
            description: "Спроектировала уютный уголок в желтых оттенках, получилось приятное сочетание",
            tags: ["Декор", "Аксессуары"],
            backgroundImage: UIImage(named: "backgroundImage"),
            authorImage: UIImage(named: "profilePhoto1"),
            authorName: "Anfisa",
            authorUsername: "annfissa",
            productLinks: [
                ProductLink(productName: "LeniTIM", productURL: "https://market.yandex.ru/"),
                ProductLink(productName: "Walling", productURL: "https://market.yandex.ru/")
            ]
        ),
        Card(
            title: "chAIRs",
            description: "Собрала для вас свою любимую подборку стульев! \n1 - lEDOmia\n2 - Chasse\n3 - hxre",
            tags: ["Стулья", "Декор"],
            backgroundImage: UIImage(named: "backgroundImage3"),
            authorImage: UIImage(named: "authorImage3"),
            authorName: "Marg.o",
            authorUsername: "margo_sha",
            productLinks: [
                ProductLink(productName: "lEDOmia", productURL: "https://market.yandex.ru/"),
                ProductLink(productName: "Chasse", productURL: "https://market.yandex.ru/"),
                ProductLink(productName: "hxre", productURL: "https://market.yandex.ru/")
            ]
        ),
        Card(
            title: "Green Life",
            description: "Выбрал новые аксессуары для своего зеленого оазиса",
            tags: ["Растения", "Аксессуары"],
            backgroundImage: UIImage(named: "backgroundImage4"),
            authorImage: UIImage(named: "authorImage4"),
            authorName: "ALex’x",
            authorUsername: "alex.00",
            productLinks: [
                ProductLink(productName: "Растенивод", productURL: "https://example.com/product1"),
                ProductLink(productName: "Растенивод 2", productURL: "https://example.com/product2")
            ]
        )
    ]
    
    @State private var showModal = false
    @State private var showProfileModal = false
    @State private var showSettingsModal = false
    @State private var selectedTags: Set<String> = []
    @State private var searchText: String = ""
    @State private var selectedCard: Card? = nil
    
    @State private var userProfile = UserProfile(
        firstName: "Anfisa",
        lastName: "Alines",
        email: "@annfissa",
        avatar: UIImage(named: "profilePhoto1")
    )

    var filteredCards: [Card] {
        cards.filter { card in
            let matchesTag = selectedTags.isEmpty || selectedTags.contains("Все") || !selectedTags.isDisjoint(with: card.tags)
            let matchesSearchText = searchText.isEmpty || card.title.localizedCaseInsensitiveContains(searchText) || card.description.localizedCaseInsensitiveContains(searchText)
            return matchesTag && matchesSearchText
        }
    }

    var sortedTags: [String] {
        let allTags = Array(Set(cards.flatMap { $0.tags }))
        let unselectedTags = allTags.filter { !selectedTags.contains($0) }
        return ["Все"] + Array(selectedTags).filter { $0 != "Все" } + unselectedTags.sorted()
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        TextField("Искать на homie", text: $searchText)
                            .padding(12)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        Button(action: {
                            showProfileModal.toggle()
                        }) {
                            Image(uiImage: userProfile.avatar ?? UIImage(named: "profilePhoto2")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(25)
                        }
                        .padding(.trailing)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(sortedTags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(selectedTags.contains(tag) ? Color.black : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedTags.contains(tag) ? .white : Color.primary)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        if tag == "Все" {
                                            selectedTags = ["Все"]
                                        } else {
                                            selectedTags.remove("Все")
                                            if selectedTags.contains(tag) {
                                                selectedTags.remove(tag)
                                            } else {
                                                selectedTags.insert(tag)
                                            }
                                        }
                                    }
                            }
                        }
                        .padding()
                    }

                    List {
                        ForEach(filteredCards) { card in
                            CardView(card: card)
                                .background(Color.clear)
                                .onTapGesture {
                                    selectedCard = card
                                }
                        }
                        .onDelete(perform: deleteCard)
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarItems(
                        trailing: HStack {
                            
                            Button(action: {
                                showSettingsModal.toggle()
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 20)
                                    .foregroundColor(.blue)
                            }
                            .padding(.leading, 15)

                            Button(action: {
                                showModal.toggle()
                            }) {
                                Image(systemName: "plus")
                            }
                            .padding(10)
                        }
                        .padding(.bottom, 30)
                    )
                    .sheet(isPresented: $showModal) {
                        AddCardView(cards: $cards)
                    }
                    .fullScreenCover(item: $selectedCard) { card in
                        CardDetailView(card: card)
                    }
                    .sheet(isPresented: $showProfileModal) {
                        ProfileView(user: $userProfile)
                    }
                    .sheet(isPresented: $showSettingsModal) {
                        SettingsView()
                    }
                }
            }
        }
    }

    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
