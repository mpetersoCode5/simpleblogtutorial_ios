//
//  EditPostVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/7/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

protocol EditPostVCProtocol
{
    func setUpdatedPost(post : Post);
}

class EditPostVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var contentTextArea: UITextView!
    var post :Post?
    var delegate : EditPostVCProtocol!
    
    var learn : LearnNSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        descriptionField.delegate = self
        contentTextArea.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        titleField.text = post?.postTitle
        descriptionField.text = post?.postDesc
        contentTextArea.text = post?.postCont
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        descriptionField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPostTapped(sender: AnyObject) {
        let id = self.post?.postID
        var postEdit = NSString(format: "postID=%d&postTitle=%@&postDesc=%@&postCont=%@", id!, titleField.text, descriptionField.text, contentTextArea.text)
        learn.editPost(postEdit)
        let date = post?.postDate
        var newPost = Post(pID: id!, pTitle: titleField.text, pDesc: descriptionField.text, pCont: contentTextArea.text, pDate: date!)
        delegate.setUpdatedPost(newPost)
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
