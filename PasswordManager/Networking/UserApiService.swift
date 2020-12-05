//
//  NetworkingService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 25/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import Firebase

class UserApiService {
    let urlSession = URLSession.shared
    let urlString = "http://192.168.1.7:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func postNewUser(user: UserDto, completion: @escaping () -> Void ){
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
            completion()
        }
        task.resume()
    }
    
    func deleteAccount() {
        var request = URLRequest(url: URL(string: urlString + "/users/\(Auth.auth().currentUser!.uid)")!)
        request.httpMethod = "DELETE"
        urlSession.dataTask(with: request).resume()
    }
    
    func fetchGroupUsers(groupId: String, completion: @escaping ([UserDetails]) -> Void) {
        let url = URL(string: urlString + "/groups/users?userUid=\(Auth.auth().currentUser!.uid)&groupId=\(groupId)")!
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let resData = data, error == nil else {
                print("REST ERROR GROUP Users FETCH")
                return
            }
            if let jsonResponse = try? self.decoder.decode([UserDetails].self, from: resData) {
                completion(jsonResponse)
            }
        }
        task.resume()
    }
    
    func deleteUserFromGroup(userId: String, groupId: String, completion: @escaping () -> Void) {
        var request = URLRequest(url: URL(string: urlString + "/groups/users?userId=\(userId)&groupId=\(groupId)")!)
        request.httpMethod = "DELETE"
        let task = urlSession.dataTask(with: request) {
            data, response, error in
            guard data != nil, error == nil else {
                return
            }
            completion()
        }
        task.resume()
    }
}
