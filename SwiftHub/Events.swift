//
//  Events.swift
//  SwiftHub
//
//  Created by Ben Chatelain on 8/4/15.
//  Copyright © 2015 phatblat. All rights reserved.
//

import Foundation

public class Events {

    public class func list() {
        /* Configure session, choose between:
        * defaultSessionConfiguration
        * ephemeralSessionConfiguration
        * backgroundSessionConfigurationWithIdentifier:
        And set session-wide properties, such as: HTTPAdditionalHeaders,
        HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
        */
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()

        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        /* Create the Request:
        Events for User (GET https://api.github.com/users/phatblat/events)
        */

        let URL = NSURL(string: "https://api.github.com/users/phatblat/events")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"

        /* Start a new Task */
//        let json = try!NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary

        let task = session.dataTaskWithRequest(request, completionHandler: {
//            (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            (data, response, error) -> Void in
            if let error = error {
                // Failure
                print("URL Session Task Failed: \(error.localizedDescription)");
            }
            else {
                // Success
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
        })
        task.resume()
    }

}
