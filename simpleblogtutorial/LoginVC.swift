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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        learn = LearnNSURLSession()
        learn.lDelegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveLoginResponse(result : NSString)
    {
        self.performSegueWithIdentifier("login", sender: self)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        learn.setupLogin(usernameField.text, password: passwordField.text)
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
