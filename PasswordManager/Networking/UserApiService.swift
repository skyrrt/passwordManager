//
//  NetworkingService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 25/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation

class UserApiService {
    let urlSession = URLSession.shared
    let urlString = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func postNewUser(user: UserDto) {
        var request = URLRequest(url: URL(string: urlString + "/users")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(user)
        
        let task = urlSession.uploadTask(with: request, from: json) { data, response, error in
            guard let responseData = data, error == nil else {
                print("REST ERROR")
                return
            }
            if let jsonResponse = try? self.decoder.decode(UserDto.self, from: responseData) {
                print(jsonResponse)
            }
        }
        task.resume()
    }
}
