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

protocol simpleblogLoginAPIProtocol {
    func didReceiveLoginResponse(result : NSString);
}

protocol simpleblogSignupAPIProtocol {
    func didReceiveSignupResponse(result : NSString);
}

class LearnNSURLSession: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    var delegate : simpleblogAPIProtocol!
    var lDelegate : simpleblogLoginAPIProtocol!
    var sDelegate : simpleblogSignupAPIProtocol!
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
    
    func httpLogin(request: NSMutableURLRequest!)
    {
        var configuration =
        NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration,
            delegate: self,
            delegateQueue:NSOperationQueue.mainQueue())
        var task = session.dataTaskWithRequest(request) {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if error != nil
            {
                
            } else {
                var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                self.login(result)
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
    
    func httpSignUp(request:NSMutableURLRequest!, body: NSString)
    {
        var configuration =
        NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration,
            delegate: self,
            delegateQueue:NSOperationQueue.mainQueue())
        
        request.HTTPMethod = "POST"
        var trueBody = body.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        
        request.HTTPBody = trueBody.dataUsingEncoding(NSUTF8StringEncoding)
        var task = session.dataTaskWithRequest(request){
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                var result = NSString(data: data, encoding:NSASCIIStringEncoding)!
                self.signup(result)
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

    
    func login(result : NSString)
    {
        if(result == "Success")
        {
            self.lDelegate?.didReceiveLoginResponse(result)
        }
    }
    
    func signup(result : NSString)
    {
        if(result == "Success")
        {
            self.sDelegate?.didReceiveSignupResponse(result)
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
    
    func editPost(body : NSString)
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://michaelserver.local:86/ios_backend/edit-post.php")!)
//        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.13/simpleblog/ios_backend/edit-post.php")!)
        httpPost(request, body: body)
        
    }
    
    func setupPost(body : NSString)
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://michaelserver.local:86/ios_backend/add-post.php")!)
//        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.13/simpleblog/ios_backend/add-post.php")!)
        httpPost(request, body : body)
    }
    
    func setupLogin(username: NSString, password: NSString)
    {
        var url : NSString = NSString(format: "http://michaelserver.local:86/ios_backend/Login.php?username=%@&password=%@", username, password)
//        var url : NSString = NSString(format: "http://192.168.1.13/simpleblog/ios_backend/Login.php?username=%@&password=%@", username, password)
        var request = NSMutableURLRequest(URL: NSURL(string:url)!)
        httpLogin(request)
    }
    
    func setupConnection()
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://michaelserver.local:86/ios_backend/index.php")!)
//         var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.13/simpleblog/ios_backend/index.php")!)
        httpGet(request)
    }
    
    func setupSignup(body : NSString)
    {
        var url : NSString = NSString(format: "http://michaelserver.local:86/ios_backend/Add-User.php")
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        httpSignUp(request, body: body)
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

