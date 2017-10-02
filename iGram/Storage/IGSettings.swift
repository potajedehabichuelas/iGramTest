//
//  IGSettings.swift
//  Alamofire
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//

import UIKit

import KeychainAccess

private let sessionTokenKey = "sessionToken"
private let instagramClientId = "InstagramClientId"

class IGSettings: NSObject {

    //Singleton
    static let sharedInstance = IGSettings()
    
    var token = IGSettings.retrieveSessionToken()
    
    class func getInstagramClientId() -> String {
        //Property clientId is stored in Plist.
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {

            if let dict = NSDictionary(contentsOfFile: path), let clientId = dict[instagramClientId] as? String  {
                return clientId
            }
        }
        return ""
    }
    
    private class func retrieveSessionToken() -> String {
        
        guard let bundleId = Bundle.main.bundleIdentifier else { return "" }
        
        let keychain = Keychain(service: bundleId)
        
        if let savedToken = keychain[sessionTokenKey] {
            return savedToken
        } else {
            return ""
        }
    }
    
    func saveSessionToken(newToken: String) -> Bool {
        
        guard let bundleId = Bundle.main.bundleIdentifier else { return false }
        
        let keychain = Keychain(service: bundleId)
        
        do {
            try keychain.set(newToken, key: sessionTokenKey)
            self.token = newToken
            
            return true
        }
        catch let error {
            print(error)
            return false
        }
    }
}
