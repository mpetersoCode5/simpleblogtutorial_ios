//
//  SignupVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/24/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class SignupVC: UIViewController, simpleblogSignupAPIProtocol {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    var learn : LearnNSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupTapped(sender: AnyObject) {
        var loginInfo = NSString(format: "username=%@&password=%@&email=%@", usernameField.text, passwordField.text, emailField.text)
        learn.signup(loginInfo)
    }

    func didReceiveSignupResponse(result: NSString) {
        performSegueWithIdentifier("login", sender: self)
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
