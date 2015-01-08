//
//  ViewPostVC.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/7/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class ViewPostVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var contentTextView: UITextView!
    var post : Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = post?.postTitle
        contentTextView.text = post?.postCont
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
