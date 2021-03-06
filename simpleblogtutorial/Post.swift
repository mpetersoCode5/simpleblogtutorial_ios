//
//  Post.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/4/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class Post: NSObject {
    var postTitle : NSString?
    var postDesc : NSString?
    var postCont : NSString?
    var postDate : NSString?
    var postID : NSInteger?
    
    init(pID: NSInteger, pTitle: NSString, pDesc : NSString, pCont : NSString, pDate : NSString)
    {
        postID = pID
        postTitle = pTitle
        postDesc = pDesc
        postCont = pCont
        postDate = pDate
    }
}
