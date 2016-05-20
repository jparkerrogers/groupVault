//
//  ViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 3/22/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class BuildAGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewCell: UITableViewCell!
    
    var usersDataSource: [User] = []
    var filteredDataSource: [User] = []
    var selectedUserIDs: [String] = []
    var currentUser = UserController.sharedController.currentUser
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserController.fetchAllUsers { (users) in
            self.usersDataSource = users.filter({ (user) -> Bool in
                return user.identifier != UserController.sharedController.currentUser.identifier
            })
            
            
            print(users.count)
            self.tableView.reloadData()
        }
        
        downSwipeGesture()
        upSwipeGesture()
        tapGestureToDismissKeyBoard()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if groupNameTextField.text == "" || selectedUserIDs == [] {
            self.showAlert("Error!", message: "Make sure you create a group name and add members.")
            
        } else {
            createGroup()
            navigationController?.popViewControllerAnimated(true)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! BuildAGroupTableViewCell
        cell.userLabel.backgroundColor = UIColor.clearColor()
        
        let user = filteredDataSource.count > 0 ? filteredDataSource[indexPath.row]:usersDataSource[indexPath.row]
        
        cell.userLabel.text = user.username
        //cell.imageView?.image = user.imageString
        
        
        
        return cell
    }
    //// self.tableview.rowHeight = UITableView UITableViewAutomaticDimension
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let user = filteredDataSource.count > 0 ? filteredDataSource[indexPath.row]:usersDataSource[indexPath.row]
            
            if selectedUserIDs.contains(user.identifier!) {
                
                if let index = selectedUserIDs.indexOf(user.identifier!) {
                    
                    selectedUserIDs.removeAtIndex(index)
                    
                    cell.backgroundColor = UIColor.whiteColor()
                }
                
            } else {
                selectedUserIDs.append(user.identifier!)
                
                cell.backgroundColor = UIColor.lightGrayColor()
                
            }
            
            
            
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    func createGroup() {
        
        if let groupName = groupNameTextField.text {
            guard let myIdentifier = UserController.sharedController.currentUser.identifier else {return}
            selectedUserIDs.append(myIdentifier)
            GroupController.createGroup(groupName, users: selectedUserIDs, completion: { (success, group) in
                if (success != nil) {
                    GroupController.passGroupIDsToUsers(self.selectedUserIDs, group:group, key: success!)
                }
                
            })
        }
        
    }
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func downSwipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(SignUpViewController.swiped))
        swipeDown.direction = .Down
        self.view.addGestureRecognizer(swipeDown)
    }
    func upSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SignUpViewController.swiped)
        )
        swipeUp.direction = .Up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    func swiped(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Down:
            groupNameTextField.resignFirstResponder()
        case UISwipeGestureRecognizerDirection.Up:
            groupNameTextField.resignFirstResponder()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        groupNameTextField.resignFirstResponder()
        return true
    }
    
    func tapGestureToDismissKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BuildAGroupViewController.hidesKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
    
    func hidesKeyboard() {
        view.endEditing(true)
    }
    
}



