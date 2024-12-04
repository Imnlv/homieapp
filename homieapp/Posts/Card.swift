//
//  Card.swift
//  homieapp
//
//  Created by Patima Imanalieva on 02.12.2024.
//

import SwiftUI

struct ProductLink: Identifiable, Hashable {
    var id = UUID()
    var productName: String
    var productURL: String
}

struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var tags: [String]
    var backgroundImage: UIImage?
    var authorImage: UIImage?
    var authorName: String
    var authorUsername: String
    var productLinks: [ProductLink]
}
