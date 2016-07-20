//
//  RegistrationViewController.swift
//  SwiftNotes
//
//  Created by Edward Jiang on 7/19/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class RegistrationViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: .exit)
    }
    
    func exit() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func register(sender: AnyObject) {
        // Code for registering the user
        let newAccount = RegistrationModel(email: emailTextField.text!, password: passwordTextField.text!)
        newAccount.givenName = firstNameTextField.text!
        newAccount.surname = lastNameTextField.text!
        
        Stormpath.sharedSession.register(newAccount) { (account, error) in
            if let account = account {
                self.exit()
            } else {
                self.showAlert(withTitle: "Error", message: error!.localizedDescription)
            }
        }
    }
    
}

private extension Selector {
    static let exit = #selector(RegistrationViewController.exit)
}
