//
//  LoginVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/3/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, simpleblogLoginAPIProtocol, UITextFieldDelegate {

    var learn : LearnNSURLSession!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameImageView: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var bottom : CGFloat = 0
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        learn = LearnNSURLSession()
        learn.lDelegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        bottom = self.bottomConstraint.constant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveLoginResponse(result : NSString)
    {
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.bottomConstraint.constant = self.bottom
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        learn.setupLogin(usernameField.text, password: passwordField.text)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.description == "Signup"
        {
            var destination : SignupVC = segue.destinationViewController as SignupVC
            destination.learn = self.learn
        }
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
