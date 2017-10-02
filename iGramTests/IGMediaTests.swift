//
//  IGMediaTests.swift
//  iGramTests
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import iGram

class IGMediaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMediaJSONParser() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "media", withExtension: "json") else {
            XCTFail("Missing file: media.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
        
            let mediaJSON = JSON(jsonContents)
            let media: IGMedia = IGMedia(mediaDict: mediaJSON)
            
            XCTAssertEqual(media.title, "@minerman_y_el_serrin gracias por el finde tematico!")
            XCTAssertEqual(media.thumbnailUrl, "wwww.thumbnail123.com")
            XCTAssertEqual(media.highResUrl, "wwww.standardresolution123123213.com/01.jpeg")
            XCTAssertEqual(media.likes, 40)
            
        } catch {
            XCTFail("Wrong file: media.json")
        }
    }
}
