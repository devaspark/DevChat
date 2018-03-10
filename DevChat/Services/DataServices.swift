//
//  DataServices.swift
//  DevChat
//
//  Created by Rex Kung on 3/6/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import Foundation
import Firebase

let REF_CHILD_USERS = "users"
let REF_CHILD_PROFILE = "profile"
let REF_CHILD_PULLREQUESTS = "pullRequests"

typealias CompletionHandler = (_ users: [User]) -> Void

class DataService {

    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child(REF_CHILD_USERS)
    }
    
    var pullReqRef: DatabaseReference {
        return mainRef.child(REF_CHILD_PULLREQUESTS)
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://devchat-178ea.appspot.com")
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        mainRef.child(REF_CHILD_USERS).child(uid).child(REF_CHILD_PROFILE).setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaUrl: URL, textSnippet: String? = nil){
        
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        
        var pr: Dictionary<String, Any> = ["mediaUrl": mediaUrl.absoluteString, "userID": senderUID, "openCount": 0, "recipients": uids]
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
    }
    
    func getUserList(onComplete: @escaping CompletionHandler) {
        var tempUserList = [User]()
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            if let users = snapshot.value as? Dictionary<String, Any> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, Any> {
                        if let profile = dict["profile"] as? Dictionary<String, Any> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let tempUser = User(uid: uid, firstName: firstName)
                                tempUserList.append(tempUser)
                            }
                            
                            
                        }
                    }
                }
            }
            onComplete(tempUserList)
        }
        
    }
    
    func sendVideo(url: URL, selectedUsers: Dictionary<String, User>) {
        let videoName = "\(NSUUID().uuidString)\(url)"
        let ref = self.videoStorageRef.child(videoName)
        _ = ref.putFile(from: url, metadata: nil, completion: { (metaData, err) in
            if err != nil {
                print("Error uploading video: \(String(describing: err?.localizedDescription))")
            } else {
                let downloadURL = metaData!.downloadURL()
                self.sendMediaPullRequest(senderUID: (Auth.auth().currentUser?.uid)!, sendingTo: selectedUsers, mediaUrl: downloadURL!, textSnippet: "")
                print("Video saved")
            }
        })
    }
    
    func sendSnap(snap: Data, selectedUsers: Dictionary<String, User>) {
        let snapName = "\(NSUUID().uuidString).jpg"
        let ref = imagesStorageRef.child(snapName)
        _ = ref.putData(snap, metadata: nil, completion: { (metaData, err) in
            if err != nil {
                print("Error uploading snap: \(String(describing: err?.localizedDescription))")
            } else {
                let downloadURL = metaData!.downloadURL()
                DataService.instance.sendMediaPullRequest(senderUID: (Auth.auth().currentUser?.uid)!, sendingTo: selectedUsers, mediaUrl: downloadURL!, textSnippet: "")
            }
        })
    }
}
