//
//  AppDelegate.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 16.11.2020.
//

import UIKit
import UXFeedbackSDK

internal func DDLogDebug(_ value: Any){
    #if DEBUG
    print(value)
    #endif
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    typealias a = [String: Any]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appBuild = Int(UIApplication.appBuild()) ?? 0
        let storedBuild = DefaultsManager.build
        
        if appBuild > storedBuild {
            DefaultsManager.urls = []
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        DDLogDebug("Start application")
        CallbackManager.addMessage("Start application")
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}

