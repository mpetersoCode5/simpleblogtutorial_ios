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
    
    func httpPost(request: NSMutableURLRequest!, body : NSString)
    {
        var configuration =
        NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration,
            delegate: self,
            delegateQueue:NSOperationQueue.mainQueue())
        
        request.HTTPMethod = "POST"
        var trueBody = body.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
//        var postString : NSString = "postTitle=IOS&postDesc=IOS&postCont=IOS";
        request.HTTPBody = trueBody.dataUsingEncoding(NSUTF8StringEncoding)
        
//        var params = ["postTitle":"From IOS", "postDesc":"This is from an IOS device", "postCont":"This is from an IOS Device"] as Dictionary<String, String>
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request){
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                var result = NSString(data: data, encoding:NSASCIIStringEncoding)!
                println(result)
            }
        }
        task.resume()
    }
    
    func tempFunc(data: NSData)
    {
        if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray
        {
            self.delegate?.didReceiveResponse(json)
        }

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
    
    func setupPost(body : NSString)
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://michaelserver.local:86/ios_backend/add-post.php")!)
        httpPost(request, body : body)
    }
    
    func setupConnection()
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://michaelserver.local:86/ios_backend/index.php")!)
        httpGet(request)
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

