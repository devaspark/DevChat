//
//  ViewController.swift
//  DevChat
//
//  Created by Rex Kung on 3/1/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class CameraVC: CameraViewController {

    
    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        self._previewView = previewView
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

