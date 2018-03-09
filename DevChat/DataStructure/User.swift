//
//  User.swift
//  DevChat
//
//  Created by Rex Kung on 3/7/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

struct User {
    private var _uid: String
    private var _firstName: String
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
    
    
}
