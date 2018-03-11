//
//  MediaCell.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import AVKit


class MediaCell: UITableViewCell {

    @IBOutlet weak var mediaBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    private var _url: URL?
    var presentVCDelegate: PresentVideoDelegate?
    
    var playerView: AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //mediaBtn.isEnabled = false
    }
    
    @IBAction func playVideo(sender: AnyObject) {
        
        playerView = AVPlayer(url: _url!)
        presentVCDelegate?.presentVideo(videoPlayer: playerView!)        
    
    }
    
    func updateUI(mediaData: MediaData) {
        userName.text = "From: \(mediaData.fromFirstName)"
        _url = mediaData.mediaURL
    }



}
