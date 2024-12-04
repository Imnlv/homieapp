//
//  AuthService.swift
//  homieapp
//
//  Created by Patima Imanalieva on 01.12.2024.
//

import Foundation

class AuthService {
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Заготовка для запроса к API
        guard let url = URL(string: "https://example.com/api/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
}
