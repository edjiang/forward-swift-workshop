//
//  NotesTableViewController.swift
//  SwiftNotes
//
//  Created by Edward Jiang on 7/19/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath

class NotesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(NotesTableViewController.logout))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        APIClient.getNotes { 
            self.tableView.reloadData()
        }
        APIClient.getAccount(callback: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return APIClient.notes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = APIClient.notes[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let notesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NotesViewController") as! NotesViewController
        notesViewController.noteId = indexPath.row
        
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
    func logout() {
        Stormpath.sharedSession.logout()
        dismissViewControllerAnimated(false, completion: nil)
    }
}
