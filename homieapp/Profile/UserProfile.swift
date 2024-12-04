//
//  UserProfile.swift
//  homieapp
//
//  Created by Patima Imanalieva on 03.12.2024.
//


import SwiftUI

struct UserProfile: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var avatar: UIImage?
}
