//
//  EditPostVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/7/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class EditPostVC: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var contentTextArea: UITextView!
    var post :Post?
    
    var learn : LearnNSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        titleField.text = post?.postTitle
        descriptionField.text = post?.postDesc
        contentTextArea.text = post?.postCont
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPostTapped(sender: AnyObject) {
        let id = self.post?.postID
        var postEdit = NSString(format: "postID=%d&postTitle=%@&postDesc=%@&postCont=%@", id!, titleField.text, descriptionField.text, contentTextArea.text)
        learn.editPost(postEdit)
        titleField.text = ""
        descriptionField.text = ""
        contentTextArea.text = ""
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
