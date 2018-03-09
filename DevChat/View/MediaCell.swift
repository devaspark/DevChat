//
//  MediaCell.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    @IBOutlet weak var mediaBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mediaBtn.isEnabled = false
    }
    
    func updateUI(mediaData: MediaData) {
        userName.text = mediaData.fromFirstName
    }



}
