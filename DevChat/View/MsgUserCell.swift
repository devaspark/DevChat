//
//  MsgUserCell.swift
//  DevChat
//
//  Created by Rex Kung on 3/11/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class MsgUserCell: UITableViewCell {


    @IBOutlet weak var firstnameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkMarked(selected: false)
        // Initialization code
    }
    
    func updateUI(user: User) {
        firstnameLbl.text = user.firstName
    }
    
    func checkMarked(selected: Bool) {
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }
}
