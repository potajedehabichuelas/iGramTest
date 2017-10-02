//
//  IGNetworkRouter.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct InstagramURL {
    
    static let base = "https://api.instagram.com/v1/"
    
    static let redirectToken = "http://www.google.com/#access_token="
    
    static let selfUserMedia = "users/self/media/recent/?access_token="
    
    static func getLoginUrl(clientId: String) -> String {
        return "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=http://www.google.com&response_type=token&scope=basic+public_content"
    }
}

enum IGRouter: URLRequestConvertible {
    
    
    // Values
    case getUserMedia(userId: String, accessToken: String)
    
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
        }
    }
    
    // Paths
    var path: String {
        switch self {
            
        case .getUserMedia(let params):
            return InstagramURL.selfUserMedia+"\(params.accessToken)"
        }
    }
    
    // endpoint parameters
    var parameters: Parameters? {
        switch self {
        case .getUserMedia( _, _):
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: InstagramURL.base+self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
            case .getUserMedia(_):
            //Set the headers
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with:nil)
        }
    }
}
