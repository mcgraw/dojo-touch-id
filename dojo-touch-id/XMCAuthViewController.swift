//
//  XMCAuthViewController.swift
//  dojo-touch-id
//
//  Created by David McGraw on 1/28/15.
//  Copyright (c) 2015 David McGraw. All rights reserved.
//

import UIKit
import LocalAuthentication

class XMCAuthViewController: UIViewController {
    
    @IBOutlet weak var passcodeField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        userAuthenticationRequired()
    }
    
    // MARK: Touch ID
    
    func userAuthenticationRequired() {
        let context: LAContext = LAContext()
        
        // Reference the error codes listed in the tutorial
        var error: NSError?
        
        // What the customer will see in the alert view
        var description = "Authenticate To Access Journal"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: { (success, error) -> Void in
                
                if success {
                    self.success()
                } else {
                    println("Something went wrong! \(error.localizedDescription)")
                    // Observe the error code to see what went wrong & guide the user to the
                    // appropriate area. For now we assume cancelation and let them proceed
                    // with entering a code.
                }
            })
        }
        
        if error != nil {
            println("Something went wrong! \(error?.localizedDescription)")
        }
    }
    
    // MARK: Standard Auth
    
    @IBAction func digitPressed(sender: AnyObject) {
        if let value = sender.tag {
            let strTag = String(value)
            passcodeField.text = "\(passcodeField.text)\(strTag)"
        }
        
        // We're done! Assume that's a valid code!
        if countElements(passcodeField.text) == 4 {
            success()
        }
    }
    
    private func success() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "usr-r")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
