//
//  SwiftHubSpec.swift
//  SwiftHub
//
//  Created by Ben Chatelain on 8/8/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

import Quick

class SwiftHubSpec: QuickSpec {

    var semaphore: dispatch_semaphore_t?

    /// Starts an async test.
    func startAsync() {
        guard let semaphore = dispatch_semaphore_create(0)
        else { fatalError("Failed to create semaphore") }

        self.semaphore = semaphore
    }

    /// Stops an async test.
    func stopAsync() {
        semaphore = nil
    }

    /// Signals the semaphore.
    func signal() {
        guard let semaphore = self.semaphore
        else { fatalError("Can't signal with a nil semaphore") }

        dispatch_semaphore_signal(semaphore)
    }

    /// Halts execution of the current queue, waiting for either the semaphore
    /// to be signaled or the given timeout (default 10s).
    /// - seconds: The number of seconds to wait for the async operation before
    /// failing the test.
    func waitForSignalOrTimeout(seconds: Int = 10) {
        guard let semaphore = self.semaphore
        else { fatalError("Can't wait on a nil semaphore") }

        let timeout = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(seconds) * NSEC_PER_SEC))
        dispatch_semaphore_wait(semaphore, timeout)
    }

}
