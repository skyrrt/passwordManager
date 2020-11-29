//
//  PasswordViewModel.swift
//  PasswordManager
//
//  Created by Bartek Rzyszkiewicz on 18/08/2020.
//  Copyright © 2020 Bartek Rzyszkiewicz. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import CryptoSwift

enum CryptoResponse {
    case error
    case response(String)
}

class PasswordViewModel: PasswordViewModelProtocol {
    
    
    var passwordCollection = BehaviorRelay<[PasswordDetails]>(value: [PasswordDetails]())
    var webService = PasswordApiService()
    let aes: AES
    
    init() {
        aes = try! AES(key: "keykeykeykeykeyk", iv: "drowssapdrowssap") //yeah, i know
    }
    
    
    func createPassword(passwordDetails: PasswordDetails) {
        let encryptionResponse = encrypt(value: passwordDetails.passwordHash)
        switch encryptionResponse {
        case .error:
            print ("error should be thrown. refactod todo")
        case .response(let encryptedPassword):
            passwordDetails.passwordHash = encryptedPassword
        }
        webService.postNewPassword(password: passwordDetails)
    }
    
    func fetchGroupPasswords() {
    }
    
    func fetchPasswords() -> Void {
        webService.fetchMyPasswords(completion: {
            passwords in
            let decryptedPasswords = passwords.map({
                (password: PasswordDetails) -> PasswordDetails in
                let decryptionResponse = self.decrypt(value: password.passwordHash)
                
                switch decryptionResponse {
                case .error:
                    print("error should be thrown. refactor todo. decryption")
                case .response(let decryptedPassword):
                    password.passwordHash = decryptedPassword
                }
                return password
            })
            self.passwordCollection.accept(decryptedPasswords)
        })
    }
    
    func encrypt(value: String) -> CryptoResponse {
        do {
            let ciphertext = try aes.encrypt(value.bytes)
            let encryptedText = ciphertext.toHexString()
            return CryptoResponse.response(encryptedText)
        } catch {
            return CryptoResponse.error
        }
    }
    
    func decrypt(value: String) -> CryptoResponse {
        do {
            let decryptedText = try aes.decrypt(Array<UInt8>(hex: value))
            let decryptedString = String(bytes: decryptedText, encoding: .utf8)
            return CryptoResponse.response(decryptedString!)
        } catch {
            return CryptoResponse.error
        }
        
    }
    
    
}
