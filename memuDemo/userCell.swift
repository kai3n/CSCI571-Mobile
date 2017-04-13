//
//  userCell.swift
//  memuDemo
//
//  Created by kaien on 4/11/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
