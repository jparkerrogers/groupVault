//
//  Messages.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 3/22/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import Foundation

class Message: FirebaseType {
    
    let kSender = "sender"
    let kText = "text"
    let kPhoto = "photo"
    let kDateString = "dateString"
    let kViewedBy = "viewedBy"
    let kIsLocked = "isLocked"
    let kGroupID = "group"
    let kSenderName = "senderName"
    
    
    var sender = ""
    var senderName: String
    var text: String?
    var photo: String?
    var dateString: String
    var timer: Timer? = Timer()
    var viewedBy: [String]?
    let groupID: String
    
    var identifier: String?
    var endpoint: String {
        return "messages"
    }
    
    var jsonValue: [String: AnyObject] {
        var json: [String: AnyObject] = [kSender: sender,kSenderName: senderName, kDateString: dateString, kGroupID: groupID]
        
        if let text = text {
            json.updateValue(text, forKey: kText)
            
            if let photo = photo {
                json.updateValue(photo, forKey: kPhoto)
                
                if let viewedBy = viewedBy {
                    json.updateValue(viewedBy, forKey: kViewedBy)
                }
            }
        }
        return json
    }
    
    required init?(json: [String: AnyObject], identifier: String) {
        
        guard let sender = json[kSender] as? String,
            let text = json[kText] as? String,
            let dateString = json[kDateString] as? String,
            let groupID = json[kGroupID] as? String,
            let senderName = json[kSenderName] as? String else { return nil }
        
        self.sender = sender
        self.text = text
        self.photo = json[kPhoto] as? String
        self.dateString = dateString
        self.viewedBy = json[kViewedBy] as? [String] ?? []
        self.groupID = groupID
        self.senderName = senderName
        self.identifier = identifier
    }
    
    init(sender: String, senderName: String, text: String?, photo: String?, dateString: String, timer: Timer?, viewedBy: [String], isLocked: Bool = false, identifier: String, groupID: String) {
        self.sender = sender
        self.text = text
        self.photo = photo
        self.dateString = dateString
        self.timer = timer
        self.viewedBy = viewedBy
        self.identifier = identifier
        self.groupID = groupID
        self.senderName = senderName
    }
}







