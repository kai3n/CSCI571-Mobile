//
//  DetailPostCell.swift
//  memuDemo
//
//  Created by kaien on 4/12/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class DetailPostCell : UITableViewCell {
    
    deinit {
        if(frameAdded){
            removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
        // perform the deinitialization
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var postContent: UILabel!
    var frameAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
