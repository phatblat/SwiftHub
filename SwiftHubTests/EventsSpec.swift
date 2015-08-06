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
import Nocilla

class EventsSpec: QuickSpec {
    var events: [String]?
    
    override func spec() {
        beforeEach {
            LSNocilla.sharedInstance().start()
        }
        afterEach {
            LSNocilla.sharedInstance().stop()
        }

        describe("events list") {
            afterEach {
                LSNocilla.sharedInstance().clearStubs()
            }

            it("can be retrieved") {
                let baseURLString = "https://api.github.com"
//                let emptyParameters = [:]
//                let service = makeJSONWebService(baseURLString: baseURLString, defaultParameters: emptyParameters)
//                stubRequest("GET", baseURLString + "/users/phatblat/events").andReturn(200).withBody("{\"ok\":1}")

                let path = NSBundle(forClass: EventsSpec.self).pathForResource("events", ofType: "json")!
                let payload = NSData(contentsOfFile: path)

                stubRequest("GET", baseURLString + "/users/phatblat/events")
                    .withHeaders(["Accept": "application/vnd.github.v3+json"])
                    .andReturnRawResponse(payload)

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
                expect(self.events?.count).to(equal(1))
            }
        }
    }
}
