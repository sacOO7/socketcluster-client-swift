//
//  File.swift
//  
//
//  Created by Sachin Shinde on 09/02/20.
//

import XCTest
@testable import Quick
@testable import Nimble
@testable import ScClient

class PublishTest: QuickSpec {
    
    override func spec() {
        describe("The PUB-SUB mechanism") {
            
            beforeSuite {
                print("Pub sub mech")
            }
            describe("The channel", closure: {
                it("should be created successfully") {
                    
                }
                
                print("The channel")
                
                describe("The publisher") {
                
                      it("is able to publish message") {
                        expect(true).to(beTruthy())
                      }

                      it("is able to publish message and receive acknowledgement") {
                        expect(true).to(beTruthy())
                      }
                    print("The publisher")
                }
                
                describe("The subscriber") {
                
                      it("is able to receive message") {
                        expect(true).to(beTruthy())
                      }

                      it("is able to publish message and receive acknowledgement") {
                        expect(true).to(beTruthy())
                      }
                    print("The subscriber")
                  }
            })
            
            afterSuite {
                
            }
        }
    }
}
