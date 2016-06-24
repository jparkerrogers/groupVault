//
//  ZFilteredResultsTableViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 6/23/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class ZFilteredResultsTableViewController: UITableViewController {
    
     var filteredDataSource: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredDataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filteredUserCell", forIndexPath: indexPath) as! BuildAGroupTableViewCell
        
        cell.filteredDelegate = self
        
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
 
}

extension ZFilteredResultsTableViewController: FilteredBuildAGroupTableViewCellDelegate {
    
    func filteredAddUserButtonTapped(sender: BuildAGroupTableViewCell) {
        
        let indexPath = tableView.indexPathForCell(sender)
        
        let user = userStatus(indexPath!)
        
        user.selectedForGroup = !user.selectedForGroup
        
        print(user.username)
        print(user.selectedForGroup)
        
        tableView.reloadData()
        
    }
    
    func userStatus(indexPath: NSIndexPath) -> User {
        
        return filteredDataSource[indexPath.row]
        
    }
    
}


