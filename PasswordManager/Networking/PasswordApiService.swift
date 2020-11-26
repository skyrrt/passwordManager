//
//  PasswordApiService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 26/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import Firebase

class PasswordApiService {
    let urlSession = URLSession.shared
    let urlString = "http://127.0.0.1:8080/passwords"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func postNewPassword(password: PasswordDetails) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(password)
        
        let task = urlSession.uploadTask(with: request, from: json) { data, response, error in
            guard let responseData = data, error == nil else {
                print("REST ERROR")
                return
            }
            if let jsonResponse = try? self.decoder.decode(PasswordDetails.self, from: responseData) {
                print(jsonResponse)
            }
        }
        task.resume()
    }
    
    func fetchMyPasswords(completion: @escaping ([PasswordDetails]) -> Void) {
        let url = URL(string: urlString + "?userId=\(Auth.auth().currentUser!.uid)")!
        let task = urlSession.dataTask(with: url) {data, response, error in
            guard let resData = data, error == nil else {
                print("REST ERROR")
                return
            }
            if let jsonResponse = try? self.decoder.decode([PasswordDetails].self, from: resData) {
                completion(jsonResponse)
            }
        }
        task.resume()
    }
}
