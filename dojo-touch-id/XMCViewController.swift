//
//  XMCViewController.swift
//  dojo-touch-id
//
//  Created by David McGraw on 1/28/15.
//  Copyright (c) 2015 David McGraw. All rights reserved.
//

import UIKit

class XMCViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // We check our flag to see if our user is indeed authenticated
        let value = NSUserDefaults.standardUserDefaults().boolForKey("usr-r")
        if !value {
            performSegueWithIdentifier("authSegue", sender: self)
        } else {
            blurView.hidden = true
        }
    }
    
}

