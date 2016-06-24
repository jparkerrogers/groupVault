//
//  FilteredResultsViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 6/21/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class FilteredResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filteredTableView: UITableView!
    
    var usersDataSource: [User] = []
    var filteredDataSource: [User] = []
    var selectedUserIDs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.fetchAllUsers { (success, users) in
            if success == true {
                self.usersDataSource = users.filter({ (user) -> Bool in
                    return user.identifier != UserController.sharedController.currentUser.identifier
                })
                //                self.stopFetchingDataIndicator()
                self.filteredTableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return filteredDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("Shalom")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("monkey", forIndexPath: indexPath) as! BuildAGroupTableViewCell
        
        cell.delegate = self
        
        let user = filteredDataSource[indexPath.row]
        
        cell.userViewOnCell(user)
        
        let selectedForGroup = user.selectedForGroup
        
        if selectedForGroup == true {
            cell.userSelectedForGroup(user)
            
        } else if selectedForGroup == false {
            cell.userNotSelectedForGroup(user)
        }
        
        return cell
        
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

extension FilteredResultsViewController: BuildAGroupTableViewCellDelegate {
    
    func filteredAddUserButtonTapped(sender: BuildAGroupTableViewCell) {
        
        let indexPath = filteredTableView.indexPathForCell(sender)
        
        let user = userStatus(indexPath!)
        
        user.selectedForGroup = !user.selectedForGroup
        
        print(user.username)
        print(user.selectedForGroup)
        
        filteredTableView.reloadData()
        
    }
    
    func addUserButtonTapped(sender: BuildAGroupTableViewCell) {
        
    }
    
    func userStatus(indexPath: NSIndexPath) -> User {
        
        return filteredDataSource[indexPath.row]
    }
    
}
