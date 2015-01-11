//
//  ViewPostVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/7/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit



class ViewPostVC: UIViewController, EditPostVCProtocol {

    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var contentTextView: UITextView!
    var post : Post?
    
    var learn : LearnNSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        titleLabel.text = post?.postTitle
        contentTextView.text = post?.postCont
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editPost"
        {
            var editPost : EditPostVC = segue.destinationViewController as EditPostVC
            editPost.post = post
            editPost.delegate = self
            editPost.learn = learn
        }
    }

    func setUpdatedPost(post: Post) {
        self.post = post
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
