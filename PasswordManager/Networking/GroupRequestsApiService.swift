//
//  GroupRequestsApiService.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 01/12/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import Firebase

class GroupRequestsApiService {
    let urlSession = URLSession.shared
    let urlString = "http://192.168.1.7:8080/requests"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func sendRequest(requestDto: GroupRequestDto) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = try? encoder.encode(requestDto)
        
        let task = urlSession.uploadTask(with: request, from: json) {
            data, response, error in
            guard let responseData = data, error == nil else {
                print("REST ERRROR GROUP REQUEST")
                return
            }
            if let jsonResponse = try? self.decoder.decode(GroupRequestDto.self, from: responseData) {
                print(jsonResponse)
            }
                
        }
        task.resume()
    }
    
    func fetchRequests(completion: @escaping ([GroupRequestDetails]) -> Void) {
        let url = URL(string: urlString + "?userUid=\(Auth.auth().currentUser!.uid)")!
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let resData = data, error == nil else {
                print("REST ERROR GROUPS FETCH")
                return
            }
            if let jsonResponse = try? self.decoder.decode([GroupRequestDetails].self, from: resData) {
                completion(jsonResponse)
            }
        }
        task.resume()
    }
    
    func answerRequest(requestId: String, answer: Bool, completion: @escaping () -> Void) {
        let url = URL(string: urlString + "?requestId=\(requestId)&accepted=\(answer)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let task = urlSession.dataTask(with: request) {
            data, response, error in
            guard data != nil, error == nil else {
                print("answer request error")
                return
            }
            completion()
        }
        task.resume()
    }
}
