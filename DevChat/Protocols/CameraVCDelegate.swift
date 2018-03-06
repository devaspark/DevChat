//
//  CameraVCDelegate.swift
//  DevChat
//
//  Created by Rex Kung on 3/3/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import Foundation
import UIKit

protocol CameraVCDelegate {
    func shouldEnableCamera(enabled: Bool)
    func shouldEnableRecording(enabled: Bool)
    func shouldEnableResumeBtn(enabled: Bool)
    func alphaResumeBtn(alphaNum: CGFloat)
    func isHiddenResumeBtn() -> Bool
    func shouldHideResumeBtn(enabled: Bool)
    func shouldEnablePhoto(enabled: Bool)
    func shouldEnableLivePhotoMode(enabled: Bool)
    func shouldHideLivePhotoMode(enabled: Bool)
    func shouldEnableDepthDataDelivery(enabled: Bool)
    func isHiddenDepthData() -> Bool
    func shouldHideDepthData(enabled: Bool)
    func setDepthDataTitle(enabled: Bool)
    func shouldEnableCaptureModeControl(enabled: Bool)
    func recordingHasStarted()
    func recordingReadyToStart()
}
