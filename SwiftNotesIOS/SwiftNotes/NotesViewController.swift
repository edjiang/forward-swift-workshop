//
//  NotesViewController.swift
//  SwiftNotes
//
//  Created by Edward Jiang on 7/19/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class NotesViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var noteId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWasShown, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardWillBeHidden, name: UIKeyboardWillHideNotification, object: nil)
        
        
        helloLabel.text = "Hello, " + (APIClient.account?.fullName ?? "Unknown")
        notesTextView.text = APIClient.notes[noteId]
    }
    
    @IBAction func logout(sender: AnyObject) {
        // Code when someone presses the logout button
        dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    func keyboardWasShown(notification: NSNotification) {
        if let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue {
            notesTextView.contentInset = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0)
            notesTextView.scrollIndicatorInsets = notesTextView.contentInset
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        notesTextView.contentInset = UIEdgeInsetsZero
        notesTextView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
}

extension NotesViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        // Add a "Save" button to the navigation bar when we start editing the
        // text field.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: .stopEditing)
    }
    
    func stopEditing() {
        // Remove the "Save" button, and close the keyboard.
        navigationItem.rightBarButtonItem = nil
        notesTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        // Code when someone exits out of the text field
        
        APIClient.saveNote(text: notesTextView.text!, id: noteId)
    }
}

private extension Selector {
    static let keyboardWasShown = #selector(NotesViewController.keyboardWasShown(_:))
    static let keyboardWillBeHidden = #selector(NotesViewController.keyboardWillBeHidden(_:))
    static let stopEditing = #selector(NotesViewController.stopEditing)
}