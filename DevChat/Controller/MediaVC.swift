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

class MediaVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PresentVideoDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var mediaMsgs = [MediaData]()
    var playerViewController: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.getMsgList { (msgList) in
            print("This is mediaMsgs count before clear: \(self.mediaMsgs.count)")
            print("This is msgList count: \(msgList.count)")
            self.mediaMsgs.removeAll()
            self.mediaMsgs = msgList
            print("This is mediaMsgs count after clear: \(self.mediaMsgs.count)")
            print("This is msgList count after clear: \(msgList.count)")
            self.tableView.reloadData()
        }
        
        /*DataService.instance.pullReqRef.observe(.value) { (snapshot) in
                if let pullReqIDs = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in pullReqIDs {
                    //print(value)
                    if let dict = value as? Dictionary<String, Any> {
                        //print(dict)
                        if let recipients = dict["recipients"] as? [String] {
                            print(recipients)
                            print("Does it get here???")
                            for uid in recipients {
                                if uid == Auth.auth().currentUser?.uid {
                                    let url = URL(string: dict["mediaUrl"] as! String)
                                    let tempMediaMsg = MediaData(fromUID: dict["userID"] as! String, fromFirstName: "Jane", mediaURL: url!)
                                    self.mediaMsgs.append(tempMediaMsg)
                                    print("We found a message")
                                }
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }*/
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell") as! MediaCell
        let mediaMsg = mediaMsgs[indexPath.row]
        cell.updateUI(mediaData: mediaMsg)
        cell.presentVCDelegate = self
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
    
}
