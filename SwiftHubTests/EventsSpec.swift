//
//  EventsSpec.swift
//  SwiftHub
//
//  Created by Ben Chatelain on 8/5/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

@testable import SwiftHub
import Quick
import Nimble

class EventsSpec: QuickSpec {
    override func spec() {
        describe("events list") {
            it("can be retrieved") {
                let sema = dispatch_semaphore_create(0)

                Events.list() { (events: [String]?) in
                    XCTAssertNotNil(events)
                    print("events \(events)")
                    // expectation.fulfill()
                    dispatch_semaphore_signal(sema)
                }

                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER)
            }
        }
    }
}
