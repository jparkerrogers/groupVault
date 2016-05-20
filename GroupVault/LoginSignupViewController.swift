//
//  LoginSignupViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 3/22/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController, UITextFieldDelegate{
    
    var user: User?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        downSwipeGesture()
        upSwipeGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if let email = emailTextField.text,
            password = passwordTextField.text {
            UserController.authenticateUser(email, password: password, completion: { (success, user) in
                if success {
                    self.performSegueWithIdentifier("toWelcomView", sender: nil)
                } else {
                    self.showLoginAlert("Invalid information", message: "Provide:\n-email\n-password (6 or more characters)")
                }
            })
        }
    }
    
    
    @IBAction func CreateAccount(sender: AnyObject) {
        
    }
    
    func downSwipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(LoginSignupViewController.swiped)
        )
        swipeDown.direction = .Down
        self.view.addGestureRecognizer(swipeDown)
    }
    func upSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(LoginSignupViewController.swiped)
        )
        swipeUp.direction = .Up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    func swiped(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.Down:
            titleLabel.resignFirstResponder()
            subtitleLabel.resignFirstResponder()
            emailLabel.resignFirstResponder()
            emailTextField.resignFirstResponder()
            passwordLabel.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        case UISwipeGestureRecognizerDirection.Up:
            titleLabel.becomeFirstResponder()
            subtitleLabel.becomeFirstResponder()
            emailLabel.becomeFirstResponder()
            emailTextField.becomeFirstResponder()
            passwordLabel.becomeFirstResponder()
            passwordTextField.becomeFirstResponder()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showLoginAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
