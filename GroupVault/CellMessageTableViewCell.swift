//
//  CellMessageTableViewCell.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 4/4/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class CellMessageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var messageTextLabel: UILabel!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
