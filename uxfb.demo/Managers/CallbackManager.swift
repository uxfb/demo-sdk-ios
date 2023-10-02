//
//  CallbackObject.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 11.09.2021.
//

import UIKit
import UXFeedbackSDK

struct Callback {
    let datetime: String
    let message: String
}

class CallbackManager: NSObject {
    public static let shared = CallbackManager()
    private static let formatter = DateFormatter()
    
    private static var messages: [Callback] = []
    
    public static func addMessage(_ message: String) {
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let callback = Callback(datetime: formatter.string(from: Date()), message: "CampaignDelegate:\n\(message)")
        messages.append(callback)
    }
    
    public static func addLog(_ message: String) {
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let callback = Callback(datetime: formatter.string(from: Date()), message: "LogDelegate:\n\(message)")
        messages.append(callback)
    }
    
    public static func getMessages() -> [Callback] {
        return messages
    }
    
    public static func clear(completion: @escaping () -> () ) {
        messages = []
        completion()
    }
}


