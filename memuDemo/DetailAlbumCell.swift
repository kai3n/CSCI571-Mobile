//
//  DetailAlbumCell.swift
//  memuDemo
//
//  Created by kaien on 4/12/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class DetailAlbumCell : UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var frameAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat { get { return 44 } }
    
    func checkHeight() {
        datePicker.isHidden = (frame.size.height < DetailAlbumCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if(!frameAdded){
            addObserver(self , forKeyPath: "frame", options: .new, context: nil )
            frameAdded = true
        }
    }
    
    func ignoreFrameChanges() {
        if(frameAdded){
            removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
//
    
    
    
}

