//
//  CameraVCDelegate.swift
//  DevChat
//
//  Created by Rex Kung on 3/3/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import Foundation

protocol CameraVCDelegate {
    func shouldEnableCamera(enabled: Bool)
    func shouldEnableRecording(enabled: Bool)
    func recordingHasStarted()
    func recordingReadyToStart()
}
