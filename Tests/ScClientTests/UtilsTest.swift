//
//  UtilsTest.swift
//  ScClient
//
//  Created by admin on 07/01/2018.
//

import XCTest
@testable import ScClient

class UtilsTest: XCTestCase {

    var counter : AtomicInteger!

    override func setUp() {
        super.setUp()
        counter = AtomicInteger()
    }

    func testShouldIncrementCounterByOne() {
        XCTAssertEqual(counter.incrementAndGet(), 1);
    }
    
    func testShouldDecrementCounterByOne() {
        counter.value = 2
        XCTAssertEqual(counter.decrementAndGet(), 1);
    }
    
    override func tearDown() {
        counter = nil
    }

}
