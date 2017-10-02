//
//  IGNetworkManager.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit

class IGNetworkManager: NSObject {
    
    //Singleton
    static let sharedInstance = IGNetworkManager()
    
    func getRecentMediaForUser(igUser: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func getInstagramLoginUrl() -> URL? {
        
        let clientId = IGSettings.getInstagramClientId()
        
        guard clientId != ""  else { return nil }
        
        return URL(string: InstagramURL.getLoginUrl(clientId: clientId))
    }
    
    func retrieveTokenFromRedirectUrl(urlString: String) -> Bool {
        
        //Retrieve token from redirect url
        let token = urlString.replacingOccurrences(of: InstagramURL.redirectToken, with: "")
        
        //If we found a token, and we can save it
        if token != "", IGSettings.sharedInstance.saveSessionToken(newToken: token) == true {
            print(token)
            return true
        }
        
        return false
    }
    
    
}
