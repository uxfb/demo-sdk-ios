//
//  ViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 16.11.2020.
//

import UIKit

class CampaignViewController: UIViewController {
    
    private let sdkManager = SdkManager.shared
    
    @IBOutlet var eventTextField: UITextField!
    
    @IBOutlet var appIdTextField: UITextField!
    
    @IBOutlet var showButton: UIButton! {
        didSet {
            showButton.layer.cornerRadius = 16
            showButton.layer.masksToBounds = true
            showButton.setTitleColor(.white, for: .normal)
            showButton.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        }
    }
    @IBOutlet var cancelButton: UIButton! {
        didSet {
            cancelButton.layer.cornerRadius = 16
            cancelButton.layer.masksToBounds = true
            cancelButton.setTitleColor(.white, for: .normal)
            cancelButton.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        }
    }
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Show campaign"
        
        SdkManager.shared.reloadCampaign()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.bottomConstraint.constant == 24 {
                self.bottomConstraint.constant = 24 + keyboardSize.height - view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.bottomConstraint.constant != 24 {
            self.bottomConstraint.constant = 24
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appIdTextField.text = DefaultsManager.selectedAppId
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sdkManager.stopCampaign()
    }
    

    @IBAction func backTap(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func showTap(_ sender: UIButton) {
        view.endEditing(true)
        sdkManager.startCampaign(with: eventTextField.text ?? "")
    }
    
    @IBAction func cancelCampaign(_ sender: UIButton) {
        view.endEditing(true)
        sdkManager.stopCampaign()
    }
}


extension CampaignViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == appIdTextField {
            ScreenManager.presentAppIds(from: self) { appId in
                self.appIdTextField.text = appId
            }
            return false
        }
        return true
    }
}
