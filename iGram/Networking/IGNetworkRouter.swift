//
//  IGNetworkRouter.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct InstagramKeys {
    static let data = "data"
    static let nameKey = "full_name"
    static let userNameKey = "username"
    static let followingKey = "follows"
    static let followedByKey = "followed_by"
}

struct InstagramURL {
    
    static let base = "https://api.instagram.com/v1/"
    
    static let redirectToken = "http://www.google.com/#access_token="
    
    static let selfUserMedia = "users/self/media/recent/?access_token="
    
    static func getSelfUserUrl(token: String) -> String {
        return "users/self/?access_token=\(token)"
    }
    
    static func getLoginUrl(clientId: String) -> String {
        return "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=http://www.google.com&response_type=token&scope=basic+public_content"
    }
}

enum IGRouter: URLRequestConvertible {
    
    // Values
    case getUserMedia(userId: String, accessToken: String)
    
    case getUserInfo(token: String)
    
    // Methods
    var method: Alamofire.HTTPMethod {
        
        switch self {
        
            /*
             ** Get Recent Media for User who owns the token **
             * GET https://api.instagram.com/v1/users/self/media/recent/?access_token=ACCESS-TOKEN
             * Get the most recent media published by the owner of the access_token.
             */
        case .getUserMedia:
            return .get
            
            /*
             ** Get User info **
             * GET https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
             * Get information about the owner of the access_token.
             */
        case .getUserInfo:
            return .get
            
        }
    }
    
    // Paths
    var path: String {
        switch self {
            
        case .getUserMedia(let params):
            return InstagramURL.selfUserMedia+"\(params.accessToken)"
        
        case .getUserInfo(let token):
            return InstagramURL.getSelfUserUrl(token: token)
        }
    }
    
    // endpoint parameters
    var parameters: Parameters? {
        
        switch self {
            
        case .getUserMedia( _, _):
            return nil
        case .getUserInfo(_):
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: InstagramURL.base+self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
            
        case .getUserMedia(_):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with:nil)
            
        case .getUserInfo(_):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with:nil)
        }
    }
}
