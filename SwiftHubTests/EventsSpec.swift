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
                let semaphore = dispatch_semaphore_create(0)

                Events.list() { (events: [String]?) in
                    XCTAssertNotNil(events)
                    print("events \(events)")
                    dispatch_semaphore_signal(semaphore)
                }

                dispatch_semaphore_wait(semaphore, 10 * NSEC_PER_SEC)
            }
        }
    }
}
