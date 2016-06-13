//
//  ReceiverCell.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 4/5/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class ReceiverCell: UITableViewCell, TimerDelegate {
    
    static let sharedCell = ReceiverCell()
    
    @IBOutlet weak var receiverDate: UILabel!
    
    @IBOutlet weak var receiverUserName: UILabel!
    
    @IBOutlet weak var sendersProfileImageView: UIImageView!
    
    @IBOutlet weak var receiverImageView: UIImageView!
    
    @IBOutlet weak var receiverMessageView: UIView!
    
    @IBOutlet weak var receiverMessageText: UILabel!
    
    @IBOutlet weak var lockAndUnlockButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var leftBubbleConstraint: NSLayoutConstraint!
    
    weak var delegate: RecieverTableViewCellDelegate?
    
    var message: Message?
    
    var cell: ReceiverCell?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        receiverImageView.hidden = true
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
            sendersProfileImageView.hidden = false
            ImageController.imageForUser(message.senderProfileImage) { (success, image) in
                if success {
                    self.sendersProfileImageView.image = image
                } else {
                    self.sendersProfileImageView.image = UIImage(named: "defaultProfileImage")
                }
            }
            receiverImageView.hidden = true
            receiverMessageView.hidden = true
            receiverMessageText.hidden = true
            receiverDate.textColor = UIColor.lightGrayColor()
            receiverDate.text = message.dateString
            receiverDate.font = UIFont.boldSystemFontOfSize(9)
            receiverUserName.font = UIFont.boldSystemFontOfSize(18)
            receiverUserName.text = message.senderName
            receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        }
    }
    
    func messageViewForReceiver(message: Message) {
        message.timer?.delegate = self
        timerLabel.hidden = false
        sendersProfileImageView.hidden = false
        receiverImageView.hidden = false
        receiverMessageView.hidden = false
        receiverMessageView.layer.masksToBounds = true
        receiverMessageView.backgroundColor = Color.lightBlueMessageColor()
        receiverMessageView.layer.cornerRadius = 8.0
        receiverMessageView.layer.borderColor = UIColor.blackColor().CGColor
        receiverMessageView.layer.borderWidth = 0.5
        receiverMessageText.hidden = false
        receiverMessageText.textColor = UIColor.blackColor()
        receiverMessageText.text = message.text
        ImageController.imageForUser(message.senderProfileImage) { (success, image) in
            if success {
                self.sendersProfileImageView.image = image
            } else {
                self.sendersProfileImageView.image = UIImage(named: "defaultProfileImage")
            }
        }
        receiverDate.textColor = UIColor.lightGrayColor()
        receiverDate.text = message.dateString
        receiverDate.font = UIFont.boldSystemFontOfSize(12)
        receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        receiverUserName.text = message.senderName
        receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        lockAndUnlockButton.hidden = true
        
    }
    
    func imageViewForReceiver(message: Message) {
        
        message.timer?.delegate = self
        sendersProfileImageView.hidden = false
        lockAndUnlockButton.hidden = true
        receiverDate.hidden = false
        timerLabel.hidden = false
        receiverImageView.hidden = false
        receiverMessageView.hidden = false
        receiverMessageText.hidden = true
        receiverImageView.hidden = false
        receiverImageView.layer.masksToBounds = true
        receiverImageView.layer.cornerRadius = 10.0
        receiverImageView.layer.borderColor = UIColor.blackColor().CGColor
        receiverImageView.layer.borderWidth = 0.5
        receiverImageView.image = message.image
        ImageController.imageForUser(message.senderProfileImage) { (success, image) in
            if success {
                self.sendersProfileImageView.image = image
            } else {
                self.sendersProfileImageView.image = UIImage(named: "defaultProfileImage")
            }
        }
        receiverDate.textColor = UIColor.lightGrayColor()
        receiverDate.text = message.dateString
        receiverDate.font = UIFont.boldSystemFontOfSize(12)
        receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        receiverUserName.text = message.senderName
        receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        lockAndUnlockButton.hidden = true

 
    }
    
    func updateTimerLabel() {
        
        timerLabel.text = message?.timer?.timeAsString()
    }
    
    
    
    func messageTimerComplete() {
        if let message = self.message {
            MessageController.userViewedMessage(message, completion: { (success, message) in
                self.goBackToLockImageView()
            })
        }
        message?.save()
    }
    
    
    func goBackToLockImageView() {
        if let message = self.message {
            timerLabel.hidden = true
            lockAndUnlockButton.hidden = false
            lockAndUnlockButton.setBackgroundImage(UIImage(named: "unlockedLock"), forState: .Normal)
            sendersProfileImageView.hidden = false
            ImageController.imageForUser(message.senderProfileImage) { (success, image) in
                if success {
                    self.sendersProfileImageView.image = image
                } else {
                    self.sendersProfileImageView.image = UIImage(named: "defaultProfileImage")
                }
            }
            receiverImageView.hidden = true
            receiverMessageView.hidden = true
            receiverMessageText.hidden = true
            receiverDate.textColor = UIColor.lightGrayColor()
            receiverDate.text = message.dateString ?? ""
            receiverDate.font = UIFont.boldSystemFontOfSize(9)
            receiverUserName.font = UIFont.boldSystemFontOfSize(18)
            receiverUserName.text = message.senderName ?? ""
            receiverUserName.font = UIFont.boldSystemFontOfSize(12)
        }
    }
}

protocol RecieverTableViewCellDelegate: class {
    func receiverLockImagebuttonTapped(sender: ReceiverCell)

}

extension ReceiverCell {
    func updateWithMessage(message: Message) {
        
    }
}
