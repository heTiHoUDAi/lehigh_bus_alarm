//
//  AppDelegate.swift
//  LBUS
//
//  Created by Zisheng Wang on 11/11/19.
//  Copyright © 2019 Zisheng Wang. All rights reserved.
//

import UIKit
import UserNotifications
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        application.setMinimumBackgroundFetchInterval(1)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {(granted, error) in if granted {
            print("User allowed notification")
            }else{
            print("user disabled notification")
            }}
        )
        application.registerForRemoteNotifications()
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        print("successful get the device token")
        print(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        print("fail to get the device token")
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
       // Check for new data.
        var soundId: SystemSoundID = 1103
        AudioServicesPlayAlertSound(soundId)
       print("Background Running")
        completionHandler(UIBackgroundFetchResult.noData)
    }

}

