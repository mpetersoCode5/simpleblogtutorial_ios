//
//  ViewController.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 12/31/14.
//  Copyright (c) 2014 Michael Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, simpleblogAPIProtocol, UITableViewDataSource, UITableViewDelegate {

    var learn : LearnNSURLSession = LearnNSURLSession()
    var posts : NSMutableArray = NSMutableArray()
    var selectedPost : Post?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        learn.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        learn.setupConnection()
    }
    
    func didReceiveResponse(results: NSArray) {
        
        posts.removeAllObjects()
        
        results.enumerateObjectsUsingBlock({ model, index, stop in
            let postTitle = model["postTitle"] as NSString
            let postDesc = model["postDesc"] as NSString
            let postCont = model["postCont"] as NSString
            let postDate = model["postDate"] as NSString
            let postID = model["postID"] as NSString
            
            let postIDInt = postID.integerValue as NSInteger
            var post = Post(pID: postIDInt, pTitle: postTitle, pDesc: postDesc, pCont: postCont, pDate: postDate)
            self.posts.addObject(post)
            
//            self.textView.text = self.textView.text + NSString(format: "%@ \n %@ \n %@ \n", postTitle, postDesc, postDate);
        });
        self.tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost = self.posts.objectAtIndex(indexPath.row) as Post
        self.performSegueWithIdentifier("ViewPost", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "BlogPostTableViewCell", bundle: nil),
            forCellReuseIdentifier: "cell")
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as BlogPostTableViewCell
        
        var post = self.posts.objectAtIndex(indexPath.row) as Post
        
//        cell.initialize()
        
        cell.titleLabel.text = post.postTitle
        
        
        var titleSplit = post.postTitle?.componentsSeparatedByString(" ")
        
        let arr = titleSplit as NSArray?
        
        var charArr = NSMutableArray()
        
        for curWord in arr!
        {
            var upper = curWord.uppercaseString as NSString
            var str = upper.substringToIndex(1)
            charArr.addObject(str)
        }
        
        var firstStr = charArr[0] as NSString
        var secondStr = charArr[1] as NSString
        
        var fullStr = firstStr.stringByAppendingString(secondStr)
        cell.IconLabel.text = fullStr
        
//        cell.textLabel?.text = post.postTitle
//        cell.detailTextLabel?.text = post.postCont
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddPost"
        {
            var addPost : AddPostVC = segue.destinationViewController as AddPostVC
            addPost.learn = self.learn
        }
        if segue.identifier == "ViewPost"
        {
            var viewPost : ViewPostVC = segue.destinationViewController as ViewPostVC
            viewPost.post = selectedPost
            viewPost.learn = learn
        }
    }
    

}

