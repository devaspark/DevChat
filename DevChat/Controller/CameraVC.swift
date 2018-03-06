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
    @IBOutlet weak var resumeBtn: UIButton!
    
    override func viewDidLoad() {
        delegate = self
        self._previewView = previewView
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        toggleMovieRecording()
    }
    
    @IBAction func cameraSwitchBtnPressed(_ sender: UIButton) {
        changeCamera()
    }
    
    /*@IBAction func resumeBtnPressed(_ sender: UIButton) {
        resumeInterruptedSession()
    }*/
    
    func shouldEnableCamera(enabled: Bool) {
        cameraBtn.isEnabled = enabled
    }
    
    func shouldEnableRecording(enabled: Bool) {
        print("Recording is: \(enabled)")
        recordBtn.isEnabled = enabled
    }
    
    func shouldEnableResumeBtn(enabled: Bool){
        resumeBtn.isEnabled = enabled
    }
    
    func alphaResumeBtn(alphaNum: CGFloat){
        resumeBtn.alpha = alphaNum
    }
    
    func isHiddenResumeBtn() -> Bool {
        return resumeBtn.isHidden
    }
    
    func shouldHideResumeBtn(enabled: Bool) {
        resumeBtn.isHidden = enabled
    }

    func shouldEnablePhoto(enabled: Bool) {
        
    }
    
    func shouldEnableLivePhotoMode(enabled: Bool) {
        
    }
    
    func shouldHideLivePhotoMode(enabled: Bool) {
        
    }
    
    func shouldEnableDepthDataDelivery(enabled: Bool) {
        
    }
    
    func isHiddenDepthData() -> Bool {
        return true
    }
    
    func shouldHideDepthData(enabled: Bool) {
        
    }
    
    func setDepthDataTitle(enabled: Bool) {
        
    }
    
    func shouldEnableCaptureModeControl(enabled: Bool) {
        
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func recordingReadyToStart() {
        print("Recording ready to start")
    }
    
}

