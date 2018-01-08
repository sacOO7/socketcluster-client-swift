
import XCTest
@testable import ScClient

class ParserTest: XCTestCase {
    
    func testShouldReturnPublish() {
        let expectedParseResult = MessageType.publish
        let actaulParseResult = Parser.parse(rid: 1, cid: 1, event: "#publish")
        XCTAssertEqual(expectedParseResult, actaulParseResult)
        
    }
    
    func testShouldReturnRemoveAuthToken() {
        let expectedParseResult = MessageType.removeToken
        let actaulParseResult = Parser.parse(rid: 1,cid:  0,event:  "#removeAuthToken")
        XCTAssertEqual(expectedParseResult, actaulParseResult)
        
    }
    
    func testShouldReturnSetAuthToken() {
        let expectedParseResult = MessageType.setToken
        let actaulParseResult = Parser.parse(rid: 1,cid:  0,event:  "#setAuthToken")
        XCTAssertEqual(expectedParseResult, actaulParseResult)
    }
    
    func testShouldReturnEvent() {
        let expectedParseResult = MessageType.event
        let actaulParseResult = Parser.parse(rid: 1,cid:  0, event: "chat")
        XCTAssertEqual(expectedParseResult, actaulParseResult)
    }
    
    func testShouldReturnIsAuthenticated() {
        let expectedParseResult = MessageType.isAuthenticated
        let actaulParseResult = Parser.parse(rid: 1,cid:  0,event:  nil)
        XCTAssertEqual(expectedParseResult, actaulParseResult)
    }
    
    func testShouldReturnAckReceive() {
        let expectedParseResult = MessageType.ackReceive
        let actaulParseResult = Parser.parse(rid: 12,cid:  0, event: nil)
        XCTAssertEqual(expectedParseResult, actaulParseResult)
    }
    
    func testShouldReturnMessageDetails() {
        let message = "{\"event\":\"#removeAuthToken\",\"data\":\"This is a sample data\",\"cid\":1, \"rid\":2, \"error\":\"This is a sample error\"}"
        let messageObject = try? JSONSerialization.jsonObject(with: message.data(using: .utf8)!, options: [])
        
        if let result = Parser.getMessageDetails(myMessage: messageObject as Any) {
            XCTAssertEqual( "This is a sample data", result.data as! String)
            XCTAssertEqual( 2, result.rid)
            XCTAssertEqual( 1, result.cid)
            XCTAssertEqual( "#removeAuthToken", result.eventName)
            XCTAssertEqual( "This is a sample error", result.error as! String)
        }
        
        
    }
    //    String(data: data, encoding: .utf8)s
    
}
