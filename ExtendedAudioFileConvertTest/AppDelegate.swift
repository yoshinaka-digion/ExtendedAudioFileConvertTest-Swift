//
//  AppDelegate.swift
//  ExtendedAudioFileConvertTest
//
//  Translated by OOPer in cooperation with shlab.jp, on 2017/1/6.
//
//
/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    The application delegate.
 */

import UIKit
import AVFoundation

@UIApplicationMain
@objc(AppDelegate)
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        do {
            
            // Configure the audio session
            let sessionInstance = AVAudioSession.sharedInstance()
            
            // our default category -- we change this for conversion and playback appropriately
            try sessionInstance.setCategory(AVAudioSessionCategoryPlayback)
            
            // we don't do anything special in the route change notification
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(handleAudioSessionRouteChangeNotification),
                                                   name: .AVAudioSessionRouteChange,
                                                   object: sessionInstance)
            
            // the session must be active for offline conversion
            try sessionInstance.setActive(true)
        } catch _ {}
        
        return true
    }
    
    // MARK: Notification Handler.
    
    @objc private func handleAudioSessionRouteChangeNotification(_ notification: Notification) {
        let reasonValue = AVAudioSessionRouteChangeReason(rawValue: notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt)!
        
        let routeDescription = notification.userInfo![AVAudioSessionRouteChangePreviousRouteKey] as! AVAudioSessionRouteDescription
        
        NSLog("Route change:")
        switch reasonValue {
        case .newDeviceAvailable:
            NSLog("     NewDeviceAvailable")
        case .oldDeviceUnavailable:
            NSLog("     OldDeviceUnavailable")
        case .categoryChange:
            NSLog("     CategoryChange")
            NSLog(" New Category: \(AVAudioSession.sharedInstance().category)")
        case .override:
            NSLog("     Override")
        case .wakeFromSleep:
            NSLog("     WakeFromSleep")
        case .noSuitableRouteForCategory:
            NSLog("     NoSuitableRouteForCategory")
        case .routeConfigurationChange:
            NSLog("     RouteConfigurationChange")
        default:
            NSLog("     ReasonUnknown")
        }
        
        NSLog("Previous route:\n")
        NSLog("%@", routeDescription)
    }
    
}