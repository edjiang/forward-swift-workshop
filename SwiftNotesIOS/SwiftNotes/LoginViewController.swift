//
//  LoginViewController.swift
//  SwiftNotes
//
//  Created by Edward Jiang on 7/19/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if Stormpath.sharedSession.accessToken != nil {
            performSegueWithIdentifier("login", sender: self)
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        // Code when someone presses the login button
        
        Stormpath.sharedSession.login(emailTextField.text!, password: passwordTextField.text!, completionHandler: openNotes)
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        // Code when someone presses the login with Facebook button
        
        Stormpath.sharedSession.login(socialProvider: .Facebook, completionHandler: openNotes)
    }
    
    @IBAction func loginWithGoogle(sender: AnyObject) {
        // Code when someone presses the login with Google button
        
        Stormpath.sharedSession.login(socialProvider: .Google, completionHandler: openNotes)
    }
    
    @IBAction func resetPassword(sender: AnyObject) {
        // Code when someone presses the reset password button
        
    }
    
    func openNotes(success: Bool, error: NSError?) {
        if success {
            performSegueWithIdentifier("login", sender: self)
        } else {
            showAlert(withTitle: "Error", message: error?.localizedDescription)
        }
    }
}

// Helper extension to display alerts easily.
extension UIViewController {
    func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}