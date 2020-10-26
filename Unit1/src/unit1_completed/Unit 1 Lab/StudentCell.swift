//
//  StudentCell.swift
//  Unit 1 Lab
//
//  Created by Mingjia Wang on 4/7/20.
//  Copyright © 2020 Mingjia Wang. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var studentNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
