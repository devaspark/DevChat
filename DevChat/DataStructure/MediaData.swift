//
//  MediaData.swift
//  DevChat
//
//  Created by Rex Kung on 3/8/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

struct MediaData {
    private var _fromUID: String
    private var _fromFirstName: String
    private var _mediaURL: URL?
    private var _messageString: String?
    private var _textSnippet: String?
    private var _isMsg: Bool?
    
    var fromUID: String {
        return _fromUID
    }
    
    var fromFirstName: String {
        return _fromFirstName
    }
    
    var mediaURL: URL? {
        return _mediaURL
    }
    
    var messageString: String? {
        return _messageString
    }
    
    var textSnippet: String? {
        return _textSnippet
    }
    
    var isMsg: Bool? {
        return _isMsg
    }
    
    init(fromUID: String, fromFirstName: String, mediaURL: URL, isMsg: Bool, messageString: String) {
        _fromUID = fromUID
        _fromFirstName = fromFirstName
        _mediaURL = mediaURL
        _isMsg = isMsg
        _messageString = messageString
    }
    
    
    
}
