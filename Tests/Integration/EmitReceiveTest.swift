//
//  File.swift
//  
//
//  Created by Sachin Shinde on 09/02/20.
//

import XCTest
@testable import Quick
@testable import Nimble

class EmitTest: QuickSpec {
    override func spec() {
      it("is friendly") {
        expect(true).to(beTruthy())
      }

      it("is smart") {
        expect(true).to(beTruthy())
      }
    }
}
