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
    let urlString = "http://192.168.1.7:8080/passwords"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func postNewPassword(password: PasswordDetails, completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(password)
        
        let task = urlSession.uploadTask(with: request, from: json) { data, response, error in
            guard data != nil, error == nil else {
                print("REST ERROR")
                return
            }
            completion()
        }
        task.resume()
    }
    
    func fetchMyPasswords(completion: @escaping ([PasswordDetails]) -> Void) {
        let url = URL(string: urlString + "?userId=\(Auth.auth().currentUser!.uid)")!
        let task = urlSession.dataTask(with: url) { data, response, error in
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
    
    func fetchGroupPasswords(completion: @escaping ([PasswordDetails]) -> Void) {
        let url = URL(string: urlString + "/groups/\(Auth.auth().currentUser!.uid)")!
        let task = urlSession.dataTask(with: url) { data, response, error in
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
    
    func deletePassword(passwordDto: PasswordDetails, completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(passwordDto)
        
        let task = urlSession.uploadTask(with: request, from: json) {
            data, response, error in
            guard data != nil, error == nil else {
                print("REST ERROR")
                return
            }
            completion()
        }
        task.resume()
    }
    
    func modifyPassword(passwordDetails: PasswordDetails, completion: @escaping () -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(passwordDetails)
        
        let task = urlSession.uploadTask(with: request, from: json) {
            data, response, error in
            guard data != nil, error == nil else {
                print("modify request error")
                return
            }
            completion()
        }
        task.resume()
    }
}
