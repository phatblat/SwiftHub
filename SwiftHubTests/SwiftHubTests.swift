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
        self.measureBlock {
            Events.list()
        }
    }

}
