import XCTest
@testable import ScClient

class MiscellaneousTest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testShouldSerializeData() {
        let emitEvent = Model.getEmitEventObject(eventName: "chat", data: "My Sample Data" as AnyObject, messageId: 2)
        let expectedData = "{\"event\":\"chat\",\"data\":\"My sample data\",\"cid\":2}"
//        XCTAssertEqual(expectedData, JSONConverter.SerializeObject(object: emitEvent))
    }
    
    func testShouldDeserializeData() {
        
    }
    
    override func tearDown() {
        
    }
    
}
