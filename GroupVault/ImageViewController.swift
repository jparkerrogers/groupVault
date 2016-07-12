//
//  ImageViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 6/24/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

//import UIKit
//
//class ImageViewController: UIViewController, ImageTimerDelegate {
//    
//    @IBOutlet weak var timerLabel: UILabel!
//    
//    @IBOutlet weak var usernameLabel: UILabel!
//    
//    @IBOutlet weak var messageImageView: UIImageView!
//    
//    var message: Message?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func cancelButtonTapped(sender: AnyObject) {
//        
//        
//    }
//    
//    func updateWith(message: Message) {
//        message.timer?.imageDelegate = self
//        self.message = message
//        self.messageImageView.image = message.image
//        self.usernameLabel.text = message.senderName
//        self.messageImageView.contentMode = UIViewContentMode.ScaleAspectFit
//    }
//    
//    func updateImageTimerLabel() {
//        if let message = self.message {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.timerLabel.text = message.timer?.timeAsString()
//            })
//        }
//    }
//    
//    func messageImageTimerComplete() {
//        if let message = self.message {
//            TimerController.sharedInstance.startTimer(message.timer ?? Timer())
//            updateImageTimerLabel()
//            if self.timerLabel.text == "00" {
//                MessageController.userViewedMessage(message, completion: { (success, message) in
//                    TimerController.sharedInstance.stopTimer(message?.timer ?? Timer())
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.goBackToMessageBoard()
//                    })
//                })
//            }
//        }
//        message?.save()
//    }
//    
//    func goBackToMessageBoard() {
//        
//        self.dismissViewControllerAnimated(true) { 
//            
//        }
////        let messageBoardVC = UIStoryboard(name: "MainOne", bundle: nil).instantiateViewControllerWithIdentifier("messageBoardVC")
////        self.presentViewController(messageBoardVC, animated: false, completion: nil)
//        
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//}
//
//protocol ImageViewControllerDelegate: class {
//    func startMessageImageTimer()
//}
