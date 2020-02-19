//
//  ClientUtilsTest.swift
//  ScClientTests
//
//  Created by admin on 12/01/2018.
//

import XCTest
@testable import ScClient

class ClientUtilsTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    

    func testShouldReturnAuthToken() {
        let event = "{\"event\":\"#setAuthToken\",\"data\": {\"token\":\"234234\"},\"cid\": 2}"
        let jsonObject = JSONConverter.deserializeString(message: event)
        let actualtoken = ClientUtils.getAuthToken(message: jsonObject)
        XCTAssertEqual("234234", actualtoken)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testShouldReturnAuthenticationFlag() {
        let event = "{\"rid\":1,\"data\":{\"id\":\"nhI9Ry88h_XpLHwEAAAF\",\"isAuthenticated\":false,\"pingTimeout\":20000}}"
        let jsonObject = JSONConverter.deserializeString(message: event)
        let actualAuthenticationFlag = ClientUtils.getIsAuthenticated(message: jsonObject)
        XCTAssertEqual(false, actualAuthenticationFlag)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


}
