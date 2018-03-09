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
}
