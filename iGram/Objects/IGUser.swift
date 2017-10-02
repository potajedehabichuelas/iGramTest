//
//  IGUser.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        
        if let uName = userDict[InstagramKeys.nameKey].string {
            self.name = uName
        }
        
        if let userN = userDict[InstagramKeys.userNameKey].string {
            self.userName = userN
        }
        
        if let follows = userDict[InstagramKeys.followingKey].int {
            self.following = follows
        }
        
        if let followedBy = userDict[InstagramKeys.followedByKey].int {
            self.followers = followedBy
        }
    }
}
