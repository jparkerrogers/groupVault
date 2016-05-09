//
//  ReceiverCell.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 4/5/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class ReceiverCell: UITableViewCell {
    
    static let sharedCell = ReceiverCell()
    
    @IBOutlet weak var recieverDate: UILabel!
    
    @IBOutlet weak var recieverUserName: UILabel!
    
    @IBOutlet weak var recieverMessageView: UIView!
    
    @IBOutlet weak var recieverMessageText: UILabel!
    
    @IBOutlet weak var lockAndUnlockButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var delegate: RecieverTableViewCellDelegate?
    
    var message: Message?
    var isLocked: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addNSNotificationObserver()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func showMessageButtonTapped(sender: AnyObject) {
        if let delegate = delegate {
            delegate.receiverLockImagebuttonTapped(self)
        }
    }
    
    func lockImageViewForReceiver() {
        if let message = self.message {
            timerLabel.hidden = true
            lockAndUnlockButton.hidden = false
            lockAndUnlockButton.setBackgroundImage(UIImage(named: "lockedLock"), forState: .Normal)
            recieverMessageView.hidden = true
            recieverMessageText.hidden = true
            recieverDate.textColor = UIColor.lightGrayColor()
            recieverDate.text = message.dateString
            recieverDate.font = UIFont.boldSystemFontOfSize(9)
            recieverUserName.font = UIFont.boldSystemFontOfSize(18)
            recieverUserName.text = message.senderName
            recieverUserName.font = UIFont.boldSystemFontOfSize(12)
            print("This is being read")
        }
    }
    
    func addNSNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReceiverCell.updateTimerLabel), name: "secondTick", object: nil)
    }
    
    func messageViewForReceiver(message: Message) {
        timerLabel.hidden = false
        recieverMessageView.hidden = false
        recieverMessageView.layer.masksToBounds = true
        recieverMessageView.layer.cornerRadius = 8.0
        recieverMessageView.backgroundColor = Color.lightBlueMessageColor()
        recieverMessageView.layer.borderColor = UIColor.blackColor().CGColor
        recieverMessageView.layer.borderWidth = 0.5
        recieverMessageText.hidden = false
        recieverMessageText.textColor = UIColor.blackColor()
        recieverMessageText.text = message.text
        recieverDate.textColor = UIColor.lightGrayColor()
        recieverDate.text = message.dateString
        recieverDate.font = UIFont.boldSystemFontOfSize(12)
        recieverUserName.font = UIFont.boldSystemFontOfSize(12)
        recieverUserName.text = message.senderName
        recieverUserName.font = UIFont.boldSystemFontOfSize(12)
        lockAndUnlockButton.hidden = true
        
    }
    
    func updateTimerLabel() {
        
        timerLabel.text = TimerController.sharedInstance.timeAsString()
        }
    
    func goBackToLockImageView() {
        if let message = self.message where timerLabel.text == "00" {
            timerLabel.hidden = true
            lockAndUnlockButton.hidden = false
            lockAndUnlockButton.setBackgroundImage(UIImage(named: "unlockedLock"), forState: .Normal)
            recieverMessageView.hidden = true
            recieverMessageText.hidden = true
            recieverDate.textColor = UIColor.lightGrayColor()
            recieverDate.text = message.dateString
            recieverDate.font = UIFont.boldSystemFontOfSize(9)
            recieverUserName.font = UIFont.boldSystemFontOfSize(18)
            recieverUserName.text = message.senderName
            recieverUserName.font = UIFont.boldSystemFontOfSize(12)
            print("This is being read")
        }
    }
}

protocol RecieverTableViewCellDelegate {
    func receiverLockImagebuttonTapped(sender: ReceiverCell)
    
}

extension ReceiverCell {
    func updateWithMessage(message: Message) {
        
    }
}
