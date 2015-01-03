//
//  AddPostVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/3/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var contentView: UITextView!
    
    var learn : LearnNSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        descriptionView.delegate = self
        contentView.delegate = self
        // Do any additional setup after loading the view.
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
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddPostTapped(sender: AnyObject) {
        var post = NSString(format: "postTitle=%@&postDesc=%@&postCont=%@", titleField.text, descriptionView.text, contentView.text)
        learn.setupPost(post)
        titleField.text = ""
        descriptionView.text = ""
        contentView.text = ""
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
