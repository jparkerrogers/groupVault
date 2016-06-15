//
//  SenderCell.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 4/5/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit


class SenderCell: UITableViewCell, SenderTimerDelegate {
    
    static let sharedCell = SenderCell()
    
    @IBOutlet weak var senderDate: UILabel!
    
    @IBOutlet weak var senderUsername: UILabel!
    
    @IBOutlet weak var senderProfileImageView: UIImageView!
    
    @IBOutlet weak var senderMessageStackView: UIStackView!
    
    @IBOutlet weak var senderMessageView: UIView!
    
    @IBOutlet weak var senderImageView: UIImageView!
    
    @IBOutlet weak var senderMessageText: UILabel!
    
    @IBOutlet weak var senderTimerLabel: UILabel!
    
    @IBOutlet weak var senderLockAndUnlockButton: UIButton!
    
    @IBOutlet weak var rightBubbleConstraint: NSLayoutConstraint!
    
    
    weak var delegate: SenderTableViewCellDelegate?
    var message: Message?
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func lockImageViewForSender() {
        if let message = self.message {
            senderTimerLabel.hidden = true
            senderProfileImageView.hidden = false
            senderLockAndUnlockButton.hidden = false
            senderLockAndUnlockButton.setBackgroundImage(UIImage(named: "unlockedLock"), forState: .Normal)
            ImageController.imageForUser(message.senderProfileImage) { (success, image) in
                if success {
                    self.senderProfileImageView.image = image
                } else {
                    self.senderProfileImageView.image = UIImage(named: "defaultProfileImage")
                }
            }
            senderMessageView.hidden = true
            senderMessageText.hidden = true
            senderUsername.text = message.senderName
            senderDate.textColor = UIColor.lightBlueMessageColor()
            senderDate.text = message.dateString
            senderDate.font = UIFont.boldSystemFontOfSize(12)
            
        }
    }
    
    func messageViewForSender(message: Message) {
        message.timer?.senderDelegate = self
        senderProfileImageView.hidden = false
        senderMessageView.layer.masksToBounds = true
        senderMessageView.layer.cornerRadius = 8.0
        senderMessageView.backgroundColor = UIColor.lightestGrayColor()
        senderMessageView.layer.borderColor = UIColor.blackColor().CGColor
        senderMessageView.layer.borderWidth = 0.5
        senderMessageText.textColor = UIColor.blackColor()
        senderMessageText.text = message.text
//        senderProfileImageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        ImageController.imageForUser(message.senderProfileImage) { (success, image) in
            if success {
                self.senderProfileImageView.image = image
            } else {
                self.senderProfileImageView.image = UIImage(named: "defaultProfileImage")
            }
        }
        senderUsername.text = message.senderName
        senderDate.text = message.dateString
        senderDate.textColor = UIColor.myLightBlueColor()
        senderDate.font = UIFont.boldSystemFontOfSize(12)
        
    }
    
    func imageViewForSender(message: Message) {
        message.timer?.senderDelegate = self
        senderProfileImageView.hidden = false
        senderMessageView.hidden = false
        senderLockAndUnlockButton.hidden = true
        senderDate.hidden = false
        senderImageView.hidden = false
        senderImageView.layer.masksToBounds = true
        senderImageView.layer.cornerRadius = 10.0
        senderImageView.layer.borderColor = UIColor.blackColor().CGColor
        senderImageView.layer.borderWidth = 0.5
        senderImageView.image = message.image
        senderProfileImageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        senderMessageStackView.hidden = true
        ImageController.imageForUser(message.senderProfileImage) { (success, image) in
            if success {
                self.senderProfileImageView.image = image
            } else {
                self.senderProfileImageView.image = UIImage(named: "defaultProfileImage")
            }
        }
        senderUsername.text = message.senderName
        senderDate.text = message.dateString
        senderDate.font = UIFont.boldSystemFontOfSize(12)
        
    }
    
    func messageTimerComplete() {
        
        if let message = self.message {
            MessageController.userViewedMessage(message, completion: { (success, message) in
                self.lockImageViewForSender()
                
            })
        }
        message?.save()
        
    }
    
    func updateTimerLabel() {
        senderTimerLabel.text = message?.timer?.timeAsString()
    }
}

protocol SenderTableViewCellDelegate: class {
    func senderMessageSent(sender: SenderCell)
    
}

extension SenderCell {
    func updateWithMessage(message: Message) {
        
    }
}