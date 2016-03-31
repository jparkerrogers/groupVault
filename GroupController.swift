//
//  GroupsController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 3/22/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import Foundation
import Firebase

class GroupController {
    
    static let sharedController = GroupController()
    
    static func groupForIdentifier(identifier: String, completion: (group: Group?) -> Void) {
        
        FirebaseController.dataAtEndpoint("groups/\(identifier)", completion: { (data) in
            if let data = data as? [String: AnyObject] {
                let group = Group(json: data, identifier: identifier)
                completion(group: group)
            } else {
                completion(group: nil)
            }
        })
    }
    
    static func createGroup(groupName: String, users: [String], completion: (success: String?, group : Group) -> Void) {
        let groupID = FirebaseController.base.childByAppendingPath("groups").childByAutoId()
        let identifier = groupID.key
        var group = Group(groupName: groupName, users: users, identifier: identifier)
        group.save()
        completion(success: identifier, group: group)
    }
    
    
    //    static func passGroupIDsToUser (user: User, group: Groups) {
    //        let user = user
    //        let group = group
    //        var groupIdentifier = group.identifier
    //        var groupIdentifierForUser: [String] = []
    //
    //        groupIdentifier = user.groupIDs as? String
    //        groupIdentifierForUser.append(groupIdentifier!)
    //
    //
    //
    //    }
    
    static func passGroupIDsToUsers(userIDs: [String], group: Group, key : String) {
        let allUserIdentifiers = FirebaseController.base.childByAppendingPath("users")
        for userID in userIDs {
            let specificUserID = allUserIdentifiers.childByAppendingPath(userID)
            let usersGroups = specificUserID.childByAppendingPath("groups")
            let specificGroup = usersGroups.childByAppendingPath(key)
            specificGroup.setValue(group.groupName)
        }
    }
}
