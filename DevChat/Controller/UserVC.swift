//
//  UserVC.swift
//  DevChat
//
//  Created by Rex Kung on 3/6/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import Firebase

class UserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    private var _videoURL: URL?
    private var _snapData: Data?
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }

    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            if let users = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, Any> {
                        if let profile = dict["profile"] as? Dictionary<String, Any> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let tempUser = User(uid: uid, firstName: firstName)
                                self.users.append(tempUser)
                            }
                            
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.checkMarked(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.checkMarked(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @IBAction func sendPRBtnPressed(sender: Any){
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            _ = ref.putFile(from: url, metadata: nil, completion: { (metaData, err) in
                if err != nil {
                    //do some error handling
                    print("Error uploading video: \(String(describing: err?.localizedDescription))")
                } else {
                    let downloadURL = metaData!.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: (Auth.auth().currentUser?.uid)!, sendingTo: self.selectedUsers, mediaUrl: downloadURL!, textSnippet: "Coding Today was legit!")
                    
                    //saved download url
                }
            })
            self.dismiss(animated: true, completion: nil)
        } else if let snap = _snapData {
            let snapName = "\(NSUUID().uuidString).jpg"
            let ref = DataService.instance.imagesStorageRef.child(snapName)
            _ = ref.putData(snap, metadata: nil, completion: { (metaData, err) in
                if err != nil {
                    //do some error handling
                    print("Error uploading video: \(String(describing: err?.localizedDescription))")
                } else {
                    let downloadURL = metaData!.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: (Auth.auth().currentUser?.uid)!, sendingTo: self.selectedUsers, mediaUrl: downloadURL!, textSnippet: "Coding Today was legit!")
                    //saved download url
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
    }

}
