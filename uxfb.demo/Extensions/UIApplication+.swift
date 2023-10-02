//
//  UIApplication+.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 20.04.2022.
//

import UIKit

extension UIApplication {
    struct Constants {
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
    }
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: Constants.CFBundleShortVersionString) as! String
    }
  
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
  
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
      
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    func currentTabBar() -> UITabBarController? {
        return self.keyWindow?.rootViewController as? UITabBarController
    }
    
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
