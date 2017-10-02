//
//  IGNetworkManager.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class IGNetworkManager: NSObject {
    
    //Singleton
    static let sharedInstance = IGNetworkManager()
    
    func getRecentMediaForUser(completion: @escaping ([IGMedia]?) -> Void) {
        
        Alamofire.request(IGRouter.getUserMedia(accessToken: IGSettings.sharedInstance.token)) .responseJSON { response in
            
            guard response.result.error == nil else {
                print("Error requesting User Media")
                print(response.result.error!)
                completion(nil)
                return
            }
            
            if let response: AnyObject = response.result.value as AnyObject? {

                //Just in case 'this' could be somehow heavy
                DispatchQueue.global(qos: .background).async {
                    let jsonMedia = JSON(response)
                    var igMediaArray = [IGMedia]()
                    
                    if let jsonArray = jsonMedia[InstagramMediaKeys.data].array {
                        
                        for mediaDict in jsonArray {
                            let media = IGMedia(mediaDict: mediaDict)
                            igMediaArray.append(media)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(igMediaArray)
                    }
                }
                
            } else {
                print("Error parsing Media Objects")
                completion(nil)
            }
        }
        
        debugPrint(request)
    }
    
    func getInstagramLoginUrl() -> URL? {
        
        let clientId = IGSettings.getInstagramClientId()
        
        guard clientId != "" else { return nil }
        
        return URL(string: InstagramURL.getLoginUrl(clientId: clientId))
    }
    
    func retrieveSelfUserInfo(completion: @escaping (IGUser?) -> Void) {
        
        Alamofire.request(IGRouter.getUserInfo(accessToken: IGSettings.sharedInstance.token)) .responseJSON { response in
        
            guard response.result.error == nil else {
                print("Error requesting user Info")
                print(response.result.error!)
                completion(nil)
                return
            }
            
            if let response: AnyObject = response.result.value as AnyObject? {
                let jsonUser = JSON(response)
                
                let user = IGUser(userDict: jsonUser[InstagramUserKeys.data])
                IGSettings.sharedInstance.currentUser = user
                completion(user)
                
            } else {
                print("Error parsing IGUser")
                completion(nil)
            }
        }
        
        debugPrint(request)
    }
    
    func retrieveTokenFromRedirectUrl(urlString: String) -> Bool {
        
        //Retrieve token from redirect url
        let token = urlString.replacingOccurrences(of: InstagramURL.redirectToken, with: "")
        
        //If we found a token, and we can save it
        if token != "", IGSettings.sharedInstance.saveSessionToken(newToken: token) == true {
            return true
        }
        
        return false
    }
    
    
}
