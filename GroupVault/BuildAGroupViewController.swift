//
//  ViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 3/22/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class BuildAGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
//    func users(completion: (users: [User]?) -> Void) {
//        
//        UserController.fetchAllUsers { (success, users) in
//            completion(users: users)
//        }
//
//    }

    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewCell: UITableViewCell!
    
    var usersDataSource: [User] = []
    var filteredDataSource: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.fetchAllUsers { (users) in
            print(users.count)
            self.usersDataSource = users
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredDataSource = usersDataSource.filter({ (user) -> Bool in
//            return user.username.lowercaseString == searchText.lowercaseString
//        })
        
        dispatch_async(dispatch_get_main_queue()) {
            self.filteredDataSource = self.usersDataSource.filter({$0.username.containsString(searchText.lowercaseString)})
            
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if filteredDataSource.count > 0 {
            return filteredDataSource.count
        } else {
            return usersDataSource.count
        }
        /// return the number of users
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usersCell", forIndexPath: indexPath)
        
        let user = filteredDataSource.count > 0 ? filteredDataSource[indexPath.row]:usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        
        return cell
    }
    //// self.tableview.rowHeight = UITableView UITableViewAutomaticDimension
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createGroup() {
        
        let groupName = groupNameTextField.text!
        
        groupsController.createGroup(groupName, users: [], completion: { (success) in
            print("just created group")
        })
    }

}


