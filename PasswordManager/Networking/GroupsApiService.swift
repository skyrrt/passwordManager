//
//  GroupsApiService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 29/11/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import Firebase

class GroupsApiService {
    let urlSession = URLSession.shared
    let urlString = "http://127.0.0.1:8080/groups"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func createGroup(groupDto: Group) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(groupDto)
        
        let task = urlSession.uploadTask(with: request, from: json) {
            data, response, error in
            guard let responseData = data, error == nil else {
                print("REST ERRROR GROUP CREATION")
                return
            }
            if let jsonResponse = try? self.decoder.decode(Group.self, from: responseData) {
                print(jsonResponse)
            }
                
        }
        task.resume()
        
    }
    
    func fetchMyGroups(completion: @escaping ([GroupDetails]) -> Void) {
        let url = URL(string: urlString + "?userUid=\(Auth.auth().currentUser!.uid)")!
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let resData = data, error == nil else {
                print("REST ERROR GROUPS FETCH")
                return
            }
            if let jsonResponse = try? self.decoder.decode([GroupDetails].self, from: resData) {
                completion(jsonResponse)
            }
        }
        task.resume()
    }
}
