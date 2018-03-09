//
//  MediaVC.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import Firebase

class MediaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var mediaMsgs = [MediaData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // DataService
        DataService.instance.pullReqRef.observeSingleEvent(of: .value) { (snapshot) in
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
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell") as! MediaCell
        let mediaMsg = mediaMsgs[indexPath.row]
        cell.updateUI(mediaData: mediaMsg)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaMsgs.count
    }
    
}
