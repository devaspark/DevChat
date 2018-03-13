//
//  MediaVC.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import AVKit
import Firebase

class MediaVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PresentVideoDelegate, PresentMessageDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var mediaMsgs = [MediaData]()
    var playerViewController: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.getMsgList { (msgList) in
            self.mediaMsgs.removeAll()
            self.mediaMsgs = msgList
            print(self.mediaMsgs)
            self.tableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell") as! MediaCell
        let mediaMsg = mediaMsgs[indexPath.row]
        cell.updateUI(mediaData: mediaMsg)
        cell.presentVCDelegate = self
        cell.presentMsgDelegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaMsgs.count
    }
    
    func presentVideo(videoPlayer: AVPlayer) {
        playerViewController = AVPlayerViewController()
        playerViewController!.player = videoPlayer
        self.present(playerViewController!, animated: true, completion: nil)
    }
    
    func presentMessage(alert: UIAlertController) {
        print("it went to the view controller")
        self.present(alert, animated: true, completion: nil)
    }
    
}
