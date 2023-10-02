//
//  SdkManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import Foundation
import UXFeedbackSDK

struct AppSettings {
    var isDebug: Bool
    var appId: String
    var delay: Int
}

struct InterfaceSettings {
    var closeOnSwipe: Bool
    var uiBlocked: Bool
    var blurSlidein: Bool
    var blurFullscreen: Bool
    var font: String?
}

struct BlurSettings {
    var color: String
    var opacity: Int
    var blur: Int
}

struct Property {
    var name: String
    var value: String
    
    var dictionary: [String: Any] {
            return [name: value]
        }
}

class SdkManager: NSObject {
    
    public static let shared = SdkManager()
    
    public var sdk = UXFeedback.sdk
    
    public var appSettings = AppSettings(isDebug: true,
                                          appId: DefaultsManager.selectedAppId,
                                          delay: 10)
    
    public var interfaceSettings = InterfaceSettings(closeOnSwipe: true,
                                                      uiBlocked: true,
                                                      blurSlidein: true,
                                                      blurFullscreen: true,
                                                      font: "Default")

    public var requestTimeout: Double = 5
    public var retryCount: Int = 3
    public var retryTimeout: Double = 10
    
    public var blurSettings = BlurSettings(color: "ABC345", opacity: 15, blur: 15)
    
    public var properties: [Property] = []
    
    public var theme: UXFBTheme = UXFBTheme()
    
    public func reloadCampaign() {
        sdk.campaignDelegate = self
        sdk.logDelegate = self
        
        
        
        sdk.stopCampaign()
        
        let settings = UXFBSettings()
        
        settings.socketTimeout = requestTimeout
        settings.retryTimeout = retryTimeout
        settings.retryCount = retryCount
        
        settings.debugEnabled = true
        
        UXFeedback.setup(appID: DefaultsManager.selectedAppId,
                         settings: settings,
                         campaignDelegate: self,
                         logDelegate: self)
    }
    
    
    public func startCampaign(with event: String) {
//        sdk.settings.globalDelayTimer = 0
        sdk.settings.closeOnSwipe = interfaceSettings.closeOnSwipe
        sdk.theme = theme

        if properties.count > 0 {
            var dict = [String:Any]()
            for property in properties {
                dict[property.name] = property.value
            }

            sdk.properties = dict
        }        
        
        sdk.startCampaign(eventName: event)
    }
    
    public func stopCampaign() {
        sdk.stopCampaign()
    }
}


extension SdkManager: UXFeedbackLogDelegate {
    func logDidReceive(message: String) {
        CallbackManager.addLog(message)
    }
}

extension SdkManager: UXFeedbackCampaignDelegate {
    func campaignDidSend(campaignId: String) {
        CallbackManager.addMessage("campaignDidSend: \(campaignId)")
    }
    
    func campaignDidAnswered(campaignId: String, answers: [String : Any]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: answers, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
            CallbackManager.addMessage("campaignDidAnswered: \(campaignId), answers - \(jsonString)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func campaignDidTerminate(eventName: String, terminatedPage: Int, totalPages: Int) {
        CallbackManager.addMessage("campaignDidTerminate: \(eventName), viewed pages - \(terminatedPage)/\(totalPages)")
    }
    
    func campaignDidShow(eventName: String) {
        CallbackManager.addMessage("campaignDidShow: \(eventName)")
    }
    
    func campaignDidClose(eventName: String) {
        CallbackManager.addMessage("campaignDidClose: \(eventName)")
    }

    func campaignDidLoad(success: Bool){
        CallbackManager.addMessage("campaignsDidLoad")
    }

    func campaignDidReceiveError(errorString: String){
        DDLogDebug(errorString)
        CallbackManager.addMessage("campaignDidReceiveError: \(errorString)")
    }
}
