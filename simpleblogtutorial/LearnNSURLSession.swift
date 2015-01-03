//
//  LearnNSURLSession.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/2/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

protocol simpleblogAPIProtocol {
    func didReceiveResponse(results: NSArray);
}

class LearnNSURLSession: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    var delegate : simpleblogAPIProtocol!
    var str : NSData!
    
//    typealias CallbackBlock = (result: String, error: String?) -> ()
//    var callback: CallbackBlock = {
//        (resultString, error) -> Void in
//        if error == nil {
//            println(resultString)
//            delegate.didReceiveResponse(resultString)
//        } else {
//            println(error)
//        }
//    }
    
    func httpGet(request: NSMutableURLRequest!){
            var configuration =
            NSURLSessionConfiguration.defaultSessionConfiguration()
            var session = NSURLSession(configuration: configuration,
                delegate: self,
                delegateQueue:NSOperationQueue.mainQueue())
            var task = session.dataTaskWithRequest(request){
                (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if error != nil {
//                    callback("", error.localizedDescription)
                    println("Found an error")
                } else {
                    var result = NSString(data: data, encoding:
                        NSASCIIStringEncoding)!
                    self.tempFunc(data)
                    //                    callback(result, nil)
                }
            }
            task.resume()
    }
    
    func tempFunc(data: NSData)
    {
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray
        {
//            let jsonArray = jsonResult as? NSArray
            self.delegate?.didReceiveResponse(json)
        }
//        var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//        let jsonArray = jsonResult as? NSArray
//        self.delegate?.didReceiveResponse(jsonArray!)

    }
    
    func URLSession(session: NSURLSession,
        didReceiveChallenge challenge:
        NSURLAuthenticationChallenge,
        completionHandler:
        (NSURLSessionAuthChallengeDisposition,
        NSURLCredential!) -> Void) {
            completionHandler(
                NSURLSessionAuthChallengeDisposition.UseCredential,
                NSURLCredential(forTrust:
                    challenge.protectionSpace.serverTrust))
    }
    
    func setupConnection()
    {
        //        var learn = LearnNSURLSession()
        var request = NSMutableURLRequest(URL: NSURL(string: "https://michaelserver.local:86/ios_backend/index.php")!)
        httpGet(request)
        //        var str = learn.getResultString()
        //        var jsonResult : AnyObject! = NSJSONSerialization.JSONObjectWithData(str, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        //        let jsonArray = jsonResult as? NSArray
        //       delegate?.didReceiveResponse(jsonArray!)
    }
    
    func getResultString() -> NSData
    {
        return str
    }
    
    func URLSession(session: NSURLSession,
        task: NSURLSessionTask,
        willPerformHTTPRedirection response:
        NSHTTPURLResponse,
        newRequest request: NSURLRequest,
        completionHandler: (NSURLRequest!) -> Void) {
            var newRequest : NSURLRequest? = request
            println(newRequest?.description);
            completionHandler(newRequest)
    }
    
    
}

