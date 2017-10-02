//
//  SettingsTests.swift
//  iGramTests
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import XCTest

@testable import iGram

class SettingsTests: XCTestCase {
    
    // Avoid using singleton so we don't interact with the app's data
    var settings: IGSettings = IGSettings()
    
    var testToken = "299334.234234dkk.-1-284993.091ksgjeit"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginUrl() {
        
        XCTAssertEqual(InstagramURL.getLoginUrl(clientId: IGSettings.getInstagramClientId()), "https://api.instagram.com/oauth/authorize/?client_id=fc8ddf533e5442ffa9e1334f767723d4&redirect_uri=http://www.google.com&response_type=token&scope=basic+public_content", "Login Url does not match prototype")
    }
    
    func testTokenSave() {
       
        if self.settings.saveSessionToken(newToken: testToken) {
            XCTAssertEqual(self.testToken, self.settings.token, "Token saved does not match test token")
        } else {
            XCTFail("Token could not be saved")
        }
    }
    
    func testTokenRetrieval() {
        XCTAssertEqual(self.testToken, self.settings.token, "Retrieved token saved does not match test token")
    }
    
}

