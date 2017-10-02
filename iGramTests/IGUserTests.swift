//
//  IGUserTests.swift
//  iGramTests
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import iGram

class IGUserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserJSONParser() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "user", withExtension: "json") else {
            XCTFail("Missing file: user.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            let userJSON = JSON(jsonContents)
            let user: IGUser = IGUser(userDict: userJSON)
            
            XCTAssertEqual(user.name, "Dani")
            XCTAssertEqual(user.userName, "yeahshad")
            
            XCTAssertEqual(user.followers, 247)
            XCTAssertEqual(user.following, 223)
        } catch {
            XCTFail("Wrong file: user.json")
        }
    }
}
