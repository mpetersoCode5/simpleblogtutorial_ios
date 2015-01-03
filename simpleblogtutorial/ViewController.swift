//
//  ViewController.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 12/31/14.
//  Copyright (c) 2014 Michael Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, simpleblogAPIProtocol {

    var learn : LearnNSURLSession = LearnNSURLSession()
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        learn.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        textView.text = ""
        learn.setupConnection()
    }
    
    func didReceiveResponse(results: NSArray) {
        results.enumerateObjectsUsingBlock({ model, index, stop in
            let postTitle = model["postTitle"] as NSString
            let postDesc = model["postDesc"] as NSString
            let postDate = model["postDate"] as NSString
            self.textView.text = self.textView.text + NSString(format: "%@ \n %@ \n %@ \n", postTitle, postDesc, postDate);
        });
        
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
    }
    

}

