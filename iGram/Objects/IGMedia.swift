//
//  IGMedia.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import SwiftyJSON

struct InstagramMediaKeys {
    static let data = "data"
    static let thumbnailImgKey = "thumbnail"
    static let highResolutionImgKey = "standard_resolution"
    static let likesKey = "likes"
    
    static let captionObjectKey = "caption"
    static let captionObjectTitleKey = "text"
}

class IGMedia: NSObject {
    
    var title: String
    var thumbnailUrl: String
    var highResUrl: String
    var likes: Int

    override init() {
        self.title = ""
        self.thumbnailUrl = ""
        self.highResUrl = ""
        self.likes = 0
    }
    
    convenience init(mediaDict: JSON) {
        
        self.init()
        
        if let mThumbImg = mediaDict[InstagramMediaKeys.thumbnailImgKey].string {
            self.thumbnailUrl = mThumbImg
        }
        
        if let mHighResImg = mediaDict[InstagramMediaKeys.highResolutionImgKey].string {
            self.highResUrl = mHighResImg
        }
        
        if let mLikes = mediaDict[InstagramMediaKeys.likesKey].int {
            self.likes = mLikes
        }
        
        //Media text is under /caption/ key
        if let mTitle = mediaDict[InstagramMediaKeys.captionObjectKey][InstagramMediaKeys.captionObjectTitleKey].string {
            self.title = mTitle
        }
    }
}
