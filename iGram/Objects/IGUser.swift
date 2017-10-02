//
//  IGUser.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import SwiftyJSON

struct InstagramUserKeys {
    static let data = "data"
    static let nameKey = "full_name"
    static let userNameKey = "username"
    static let followingKey = "follows"
    static let followedByKey = "followed_by"
    static let countsKey = "counts"
}

class IGUser: NSObject {

    var name: String
    var followers: Int
    var following: Int
    var userName: String
    
    override init() {
        
        self.userName = ""
        self.name = ""
        self.followers = 0
        self.following = 0
    }
    
    convenience init(userDict: JSON) {
        
        self.init()
        
        if let uName = userDict[InstagramUserKeys.nameKey].string {
            self.name = uName
        }
        
        if let userN = userDict[InstagramUserKeys.userNameKey].string {
            self.userName = userN
        }
        
        if let follows = userDict[InstagramUserKeys.countsKey][InstagramUserKeys.followingKey].int {
            self.following = follows
        }
        
        if let followedBy = userDict[InstagramUserKeys.countsKey][InstagramUserKeys.followedByKey].int {
            self.followers = followedBy
        }
    }
}
