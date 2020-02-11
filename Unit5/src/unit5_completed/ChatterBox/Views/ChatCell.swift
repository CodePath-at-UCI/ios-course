//
//  ChatCell.swift
//  ChatterBox
//
//  Created by Memo on 12/7/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
