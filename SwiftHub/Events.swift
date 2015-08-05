//
//  Events.swift
//  SwiftHub
//
//  Created by Ben Chatelain on 8/4/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

import Dispatch
import Foundation

public typealias EventList = (events: [String]?) -> Void

public class Events {

    public class func list(queue: dispatch_queue_t = dispatch_get_main_queue(), callback: EventList) {
        /* Configure session, choose between:
        * defaultSessionConfiguration
        * ephemeralSessionConfiguration
        * backgroundSessionConfigurationWithIdentifier:
        And set session-wide properties, such as: HTTPAdditionalHeaders,
        HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
        */
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.HTTPAdditionalHeaders = ["Accept": "application/vnd.github.v3+json"]

        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
        Events for User (GET https://api.github.com/users/phatblat/events)
        */

        let URL = NSURL(string: "https://api.github.com/users/phatblat/events")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: {
//            (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            (data: NSData?,  response: NSURLResponse?, error: NSError?) -> Void in
//            (data, response, error) -> Void in

            if let error = error {
                // Failure
                print("URL Session Task Failed: \(error.localizedDescription)");
                dispatch_sync(queue) {
                    callback(events: nil)
                }
            }
            else {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
//        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                dispatch_sync(queue) {
                    callback(events: [""])
                }
            }
        })

        task.resume()
    }

}
