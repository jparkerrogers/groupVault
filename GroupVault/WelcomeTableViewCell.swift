//
//  WelcomeTableViewCell.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 6/8/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    
//    @IBOutlet weak var blurView: UIView!
//    
//    @IBOutlet weak var fetchingDataIndicator: UIActivityIndicatorView!
    
    var group: Group?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        blurView.hidden = true
//        fetchingDataIndicator.hidesWhenStopped = true
//        fetchingDataIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func groupViewOnCell(group: Group) {
        if let groupID = group.identifier {
            ImageController.groupImageForIdentifier(groupID, completion: { (image) in
                if let groupImage = image {
                    self.groupImageView.image = groupImage
                } else {
                    self.groupImageView.image = UIImage(named: "defaultProfileImage")
                }
            })
        
        }

        groupImageView.layer.cornerRadius = 5.0
        groupImageView.clipsToBounds = true
        groupImageView.contentMode = UIViewContentMode.ScaleAspectFit
        groupImageView.layer.borderColor = UIColor.myDarkGrayColor().CGColor
        groupImageView.layer.borderWidth = 0.5
        groupImageView.alpha = 1.0
        
        self.groupNameLabel.text = group.groupName
        self.group = group
    }
    
//    func startFetchingDataIndicator() {
//        self.blurView.hidden = false
//        self.fetchingDataIndicator.startAnimating()
//        
//        
//    }
//    
//    func stopFetchingDataIndicator() {
//        self.blurView.hidden = true
//        self.fetchingDataIndicator.stopAnimating()
//    }
    
}
