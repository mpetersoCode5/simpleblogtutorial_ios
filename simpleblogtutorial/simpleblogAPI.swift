//
//  simpleblogAPI.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 12/31/14.
//  Copyright (c) 2014 Michael Peterson. All rights reserved.
//

import UIKit

protocol simpleblogAPIProtocol {
//    func didReceiveResponse(results: NSDictionary)
    func didReceiveResponse(results: NSArray)

}



class simpleblogAPI: NSObject {
    var data : NSMutableData = NSMutableData()
    
    var delegate : simpleblogAPIProtocol?
    
    var learn : LearnNSURLSession
    
    init(session : LearnNSURLSession)
    {
        learn = session
    }
    
//    func setupConnection()
//    {
//        var urlPath = "https://michaelserver.local:86/ios_backend/index.php"
//        var url : NSURL = NSURL(string: urlPath)!
//        var urlRequest : NSURLRequest = NSURLRequest(URL: url)
//        var connection : NSURLConnection = NSURLConnection(request: urlRequest, delegate: self, startImmediately: false)!
//        
//        connection.start()
//    }
//    
//    //NSURLConnection connection failed
//    func connection(connection : NSURLConnection!, didFailWithError error: NSError)
//    {
//        
//    }
//    
//    //New request so we need to clear the data object
//    func connection(didRecieveResponse: NSURLConnection!, didReceiveResponse response:NSURLResponse!)
//    {
//        self.data = NSMutableData()
//    }
//    
//    //Append incoming data
//    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
//    {
//        self.data.appendData(data);
//    }
    
    func setupConnection()
    {
//        var learn = LearnNSURLSession()
        var request = NSMutableURLRequest(URL: NSURL(string: "https://michaelserver.local:86/ios_backend/index.php")!)
        learn.httpGet(request)
//        var str = learn.getResultString()
//        var jsonResult : AnyObject! = NSJSONSerialization.JSONObjectWithData(str, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//        let jsonArray = jsonResult as? NSArray
//       delegate?.didReceiveResponse(jsonArray!)
    }
    
    //NSUrlConnection Delegate Function
    func connectionDidFinishLoading(connection : NSURLConnection!)
    {
        //Finished receiving data and convert it to a JSON object
//        var jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var jsonResult : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        let jsonArray = jsonResult as? NSArray
        
//        delegate?.didReceiveResponse(jsonResult)
        delegate?.didReceiveResponse(jsonArray!)
    }
    
}
