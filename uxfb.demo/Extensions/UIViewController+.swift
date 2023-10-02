//
//  UIViewController+.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    static func get<T: UIViewController>(_ type: T.Type, storyboard: String) -> T? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let identifier = String(describing: T.self)
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            return nil
        }
        
        return vc
    }
    
    func topMostViewController() -> UIViewController? {
        if let tabBar = self as? UITabBarController {
            if let navBar =  tabBar.selectedViewController?.topMostViewController() as? UINavigationController {
                return navBar.visibleViewController?.topMostViewController()
            }
            
            return tabBar.selectedViewController?.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tabBar = self.presentedViewController as? UITabBarController {
            if let selectedTab = tabBar.selectedViewController {
                return selectedTab.topMostViewController()
            }
            
            return tabBar.topMostViewController()
        }
        
        return self.presentedViewController!.topMostViewController()
    }
    
    func addCloseButton() {
        let barButton = UIBarButtonItem(title: "Закрыть",
                                        style: .plain,
                                        target: self,
                                        action: #selector(close))
        
        barButton.tintColor = .blue
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
}
