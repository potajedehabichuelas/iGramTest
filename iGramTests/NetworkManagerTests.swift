//
//  NetworkManagerTests.swift
//  iGramTests
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import XCTest

@testable import iGram

class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRetrieveMediaRequest() {
        
        let ex = expectation(description: "Expecting a JSON Media data")
        
        IGNetworkManager.sharedInstance.getRecentMediaForUser(completion: { mediaObjects in
            
            XCTAssertNil(mediaObjects)
            if let mediaArray = mediaObjects {
                XCTAssertGreaterThanOrEqual(mediaArray.count, 0)
            }
            ex.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testSelfUserInfoRequest() {
        
        let ex = expectation(description: "Expecting a JSON User data")
        
        IGNetworkManager.sharedInstance.retrieveSelfUserInfo(completion: { user in
            XCTAssertNotNil(user)
            ex.fulfill()
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}
