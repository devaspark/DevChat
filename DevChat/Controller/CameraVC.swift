//
//  ViewController.swift
//  DevChat
//
//  Created by Rex Kung on 3/1/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit

class CameraVC: CameraViewController, CameraVCDelegate {
  
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    override func viewDidLoad() {
        self._previewView = previewView
        delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func cameraSwitchBtnPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    
    func shouldEnableCamera(enabled: Bool) {
        cameraBtn.isEnabled = enabled
    }
    
    func shouldEnableRecording(enabled: Bool) {
        recordBtn.isEnabled = enabled
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func recordingReadyToStart() {
        print("Recording ready to start")

    }
    
}

