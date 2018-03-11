//
//  ViewController.swift
//  DevChat
//
//  Created by Rex Kung on 3/1/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import UIKit
import Firebase

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
    
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            performSegue(withIdentifier: "GoToLoginVC", sender: nil)
            return
        }
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
    
    @IBAction func MessageBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "MessageVC", sender: nil)
    }
    
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
    
    func videoRecordingFailed() {
        
    }
    
    func videoRecordingComplete(videoURL: URL) {
        performSegue(withIdentifier: "UserVC", sender: ["videoURL": videoURL])
    }
    
    func snapshotFailed() {
        
    }
    
    func snapshotTaken(snapshotData: Data) {
        performSegue(withIdentifier: "UserVC", sender: ["snapshotData": snapshotData])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UserVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoURL"]
                usersVC.videoURL = url
                
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                usersVC.snapData = snapData
            }
        }
    }
    
}

