//
//  EventsSpec.swift
//  SwiftHub
//
//  Created by Ben Chatelain on 8/5/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

import SwiftHub
import Quick
import Nimble

class EventsSpec: QuickSpec {
    override func spec() {
        describe("events list") {
            it("can be retrieved") { [unowned self] in
                let expectation: XCTestExpectation = self.expectationWithDescription("asynchronous request")
                
                Events.list() { (events: [String]?) in
                    XCTAssertNotNil(events)
                    print("events \(events)")
                    expectation.fulfill()
                }
                
                self.waitForExpectationsWithTimeout(10, handler: nil)
            }
        }
    }
}
