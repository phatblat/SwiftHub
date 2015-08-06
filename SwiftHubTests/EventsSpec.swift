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
    var events: [String]?
    
    override func spec() {
        describe("events list") {
            it("can be retrieved") {
                guard let semaphore = dispatch_semaphore_create(0)
                else { fatalError("Failed to create semaphore") }

                Events.list() { (events: [String]?) in
                    expect(events).toNot(beNil())
                    print("events \(events)")
                    self.events = events

                    dispatch_semaphore_signal(semaphore)
                }

                let timeout = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * NSEC_PER_SEC))
                dispatch_semaphore_wait(semaphore, timeout)
                
                expect(self.events).toNot(beNil())
                expect(self.events?.count).to(equal(30))
            }
        }
    }
}
