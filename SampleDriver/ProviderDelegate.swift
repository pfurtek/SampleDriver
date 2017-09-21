//
//  ProviderDelegate.swift
//  SampleDriver
//
//  Created by Pawel Furtek on 12/12/16.
//  Copyright © 2016 Pawel Furtek. All rights reserved.
//

import UIKit
import CallKit

class ProviderDelegate: NSObject, CXProviderDelegate {
    private let provider: CXProvider
    
    override init() {
        provider = CXProvider(configuration: type(of: self).providerConfiguration)
        
        super.init()
        
        provider.setDelegate(self, queue: nil)
    }
    
    static var providerConfiguration: CXProviderConfiguration {
        let localizedName = NSLocalizedString("Carbon Ride Request", comment: "Name of application")
        let providerConfiguration = CXProviderConfiguration(localizedName: localizedName)
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.phoneNumber, .emailAddress, .generic]
        if let iconMaskImage = UIImage(named: "IconMask") {
            providerConfiguration.iconTemplateImageData = UIImagePNGRepresentation(iconMaskImage)
        }
        providerConfiguration.ringtoneSound = "Ringtone.caf"
        return providerConfiguration
    }
    
    func reportIncomingCall(_ uuid: UUID, handle: CXHandle, hasVideo: Bool = false, completion: ((Error?) -> Void)? = nil) {
        // Construct a CXCallUpdate describing the incoming call, including the caller.
        let update = CXCallUpdate()
        update.remoteHandle = handle
        update.hasVideo = hasVideo
        self.provider.reportNewIncomingCall(with: uuid, update: update) { error in
            completion?(error)
        }
    }
    
    func providerDidReset(_ provider: CXProvider) {
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        print("end")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        print("start")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        print("answer")
        action.fulfill()
        provider.reportCall(with: action.callUUID, endedAt: Date(), reason: .answeredElsewhere)
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        print("held")
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
        print("timedout")
    }
}
