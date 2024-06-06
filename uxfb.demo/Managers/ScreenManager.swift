//
//  ScreenManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class ScreenManager: NSObject {
  
  private static let mainStoryboard = "Main"
  
  private static var window = (UIApplication.shared.delegate as? AppDelegate)?.window
  
  private static func navigationFor(_ viewController: UIViewController) -> UINavigationController {
    let nc = UINavigationController(rootViewController: viewController)
    return nc
  }
  
  private static func presentController(_ viewController: UIViewController, at target: UIViewController? = nil, presentationStyle: UIModalPresentationStyle = .pageSheet) {
    let nc = navigationFor(viewController)
    
    if target == nil {
      let vc = UIApplication.shared.topMostViewController()
      vc?.present(nc, animated: true, completion: nil)
    }
    else {
      target!.present(nc, animated: true, completion: nil)
    }
  }
  
  //MARK: - Navigation
  
  static func presentAppIds(from target: UIViewController, completion: @escaping (String) -> ()) {
    let controller = UIViewController.get(AppIdViewController.self,
                                          storyboard: mainStoryboard)!
    controller.completion = completion
    presentController(controller, at: target)
  }
  
  static func presentPorperties(from target: UIViewController) {
    let controller = UIViewController.get(PropertyViewController.self,
                                          storyboard: mainStoryboard)!
    presentController(controller, at: target)
  }
  
  static func presentTheme(from target: UIViewController) {
    let controller = UIViewController.get(ThemeViewController.self,
                                          storyboard: mainStoryboard)!
    presentController(controller, at: target)
  }
  
  static func presentSettingsSdk(from target: UIViewController) {
    let controller = UIViewController.get(SdkSettingsViewController.self,
                                          storyboard: mainStoryboard)!
    presentController(controller, at: target)
  }
  
  static func presentAttribute(from target: UIViewController) {
    let controller = UIViewController.get(AttributeViewController.self,
                                          storyboard: mainStoryboard)!
    controller.delegate = target as? any AttributeDelegate
    presentController(controller, at: target)
  }
}
