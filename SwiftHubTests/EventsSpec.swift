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

class EventsSpec: SwiftHubSpec {
    var events: [String]?
    
    override func spec() {
        beforeEach {
            LSNocilla.sharedInstance().start()
        }
        afterEach {
            LSNocilla.sharedInstance().stop()
        }

        describe("events list") {
            beforeEach {
                self.startAsync()
            }
            afterEach {
                self.stopAsync()
                LSNocilla.sharedInstance().clearStubs()
            }

            it("can be retrieved") {
                let baseURLString = "https://api.github.com"

                let path = NSBundle(forClass: EventsSpec.self).pathForResource("events", ofType: "json")!
                let payload = NSData(contentsOfFile: path)

                stubRequest("GET", baseURLString + "/users/phatblat/events")
                    .withHeaders(["Accept": "application/vnd.github.v3+json"])
                    .andReturnRawResponse(payload)


                Events.list() { (events: [String]?) in
                    expect(events).toNot(beNil())
                    print("events \(events)")
                    self.events = events

                    self.signal()
                }

                self.waitForSignalOrTimeout()
                
                expect(self.events).toNot(beNil())
                expect(self.events?.count).to(equal(1))
            }
        }
    }
}
