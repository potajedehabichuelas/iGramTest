//
//  IGNetworkManager.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit

class IGNetworkManager: NSObject {
    
    var token: String = ""
    
    //Singleton
    static let sharedInstance = IGNetworkManager()
    
    func getRecentMediaForUser(igUser: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func retrieveTokenFromRedirectUrl(urlString: String) -> Bool {
        
        //Retrieve token from redirect url
        let token = urlString.replacingOccurrences(of: InstagramURL.redirectToken, with: "")
        
        if token != "" {
            print(token)
            //Save token
            self.token = token
            

            return true
        }
        
        return false
    }
    
    
}
