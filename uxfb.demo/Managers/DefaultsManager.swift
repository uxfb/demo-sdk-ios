//
//  DefaultsManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 02.02.2022.
//

import Foundation

class DefaultsManager: NSObject {
    
    private static let defaults = UserDefaults.standard
    
    static var build: Int {
        get { return defaults.integer(forKey: "build") }
        set { defaults.set(newValue, forKey: "build") }
    }
    
    static var urls: [String] {
        get { return (defaults.object(forKey: "urls") as? [String]) ?? [] }
        set {
            let unique = Array(Set(newValue))
            defaults.set(unique, forKey: "urls")
        }
    }
    
    static var appIds: [String] {
        get { return (defaults.object(forKey: "appIds") as? [String]) ?? [] }
        set {
            let unique = Array(Set(newValue))
            defaults.set(unique, forKey: "appIds")
        }
    }
    
    static var selectedAppId: String {
        get { return (defaults.object(forKey: "selectedAppId") as? String) ?? "" }
        set {
            defaults.set(newValue, forKey: "selectedAppId")
        }
    }
}
