//
//  APIClient.swift
//  SwiftNotes
//
//  Created by Edward Jiang on 7/19/16.
//  Copyright © 2016 Stormpath. All rights reserved.
//

import UIKit
import Stormpath
import SwiftyJSON

typealias APIClientCallback = () -> Void

class APIClient {
    static var baseUrl = NSURL(string: "http://localhost:3000")!
    static var notes = [String]()
    
    static var account: Account?
    
    static func getAccount(callback callback: APIClientCallback?) {
        Stormpath.sharedSession.me { (account, error) in
            self.account = account
            callback?()
        }
    }
    
    static func getNotes(callback callback: APIClientCallback?) {
        let request = urlRequest(endpoint: "/notes")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            let json = JSON(data: data!)
            var newNotes = [String]()
            
            if let jsonNotes = json["notes"].array {
                for note in jsonNotes {
                    newNotes.append(note.stringValue)
                }
            }
            notes = newNotes
            
            if let callback = callback {
                dispatch_async(dispatch_get_main_queue(), callback)
            }
        }
        task.resume()
    }
    
    static func createNote(text text: String) {
        let json: JSON = ["notes": text]
        
        let request = urlRequest(endpoint: "/notes")
        request.HTTPMethod = "POST"
        request.HTTPBody = try? json.rawData()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        task.resume()
    }
    
    static func saveNote(text text: String, id: Int) {
        var json = JSON([String: String]())
        json["notes"].string = text
        
        let request = urlRequest(endpoint: "/notes/\(id)")
        request.HTTPMethod = "POST"
        request.HTTPBody = try? json.rawData()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        task.resume()
    }
    
    static func urlRequest(endpoint endpoint: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: baseUrl.URLByAppendingPathComponent(endpoint))
        request.setValue("Bearer " + Stormpath.sharedSession.accessToken!, forHTTPHeaderField: "Authorization")
        
        return request
    }
}