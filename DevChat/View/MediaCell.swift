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
    var presentMsgDelegate: PresentMessageDelegate?
    
    var isMessage: Bool?
    var playerView: AVPlayer?
    private var _messageText: String?
    
    var messageText: String? {
        return _messageText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //mediaBtn.isEnabled = false
    }
    
    @IBAction func playVideo(sender: AnyObject) {
        
        if (isMessage!) {
            print(messageText)
            
            let msg = UIAlertController(title: userName.text, message: messageText, preferredStyle: .alert)
            msg.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            presentMsgDelegate?.presentMessage(alert: msg)
        } else {
            playerView = AVPlayer(url: _url!)
            presentVCDelegate?.presentVideo(videoPlayer: playerView!)
        }
    }
    
    func updateUI(mediaData: MediaData) {
        userName.text = "From: \(mediaData.fromFirstName)"
        _url = mediaData.mediaURL
        isMessage = mediaData.isMsg
        print("this is a message from media data \(mediaData.messageString)")
        if let isAMsg = isMessage, isAMsg == true {
            let image = UIImage(named: "addphoto_btn.png")
            mediaBtn.setImage(image, for: .normal)
            
            _messageText = mediaData.messageString
        }
    }



}
