//
//  IGSettings.swift
//  Alamofire
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//

import UIKit

import KeychainAccess

class IGSettings: NSObject {

    //Singleton
    static let sharedInstance = IGSettings()
    
    var token = IGSettings.retrieveSessionToken()
    
    private class func retrieveSessionToken() -> String {
        
        let keychain = Keychain(service: "com.genius.iGram")
        
        if let savedToken = keychain["sessionToken"] {
            return savedToken
        } else {
            return ""
        }
    }
    
    func saveSessionToken(newToken: String) -> Bool {
        
        let keychain = Keychain(service: "com.genius.iGram")
        
        do {
            try keychain.set(newToken, key: "sessionToken")
            self.token = newToken
            
            return true
        }
        catch let error {
            print(error)
            return false
        }
    }
}
