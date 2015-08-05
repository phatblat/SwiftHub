//
//  SwiftHubTests.swift
//  SwiftHubTests
//
//  Created by Ben Chatelain on 8/4/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

import XCTest
@testable import SwiftHub

class SwiftHubTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEventsList() {
        let expectation: XCTestExpectation = expectationWithDescription("asynchronous request")

        Events.list() { (events: [String]?) in
            XCTAssertNotNil(events)
            print("events \(events)")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
