//
//  ViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 16.11.2020.
//

import UIKit

class CampaignViewController: UIViewController {
  
  private let sdkManager = SdkManager.shared
  
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
      tableView.dataSource = self
      tableView.delegate = self
      tableView.backgroundColor = .clear
    }
  }
  
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
//    sdkManager.stopCampaign()
  }
  
  
  @IBAction func backTap(_ sender: UITapGestureRecognizer){
    view.endEditing(true)
  }
  
  @IBAction func showTap(_ sender: UIButton) {
    view.endEditing(true)
    
    let attributes = sdkManager.attributesBuilder.build()
    sdkManager.startCampaign(with: eventTextField.text ?? "", attributes: attributes)
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

extension CampaignViewController: AttributeDelegate {
  func attributesAdded(name: String, value: any Codable) {
    if type(of: value) == String.self {
      let _ = sdkManager.attributesBuilder.addValue(name, value: value as! String)
    } else if type(of: value) == Int.self {
      let _ = sdkManager.attributesBuilder.addValue(name, value: value as! Int)
    } else if type(of: value) == Double.self {
      let _ = sdkManager.attributesBuilder.addValue(name, value: value as! Double)
    } else if type(of: value) == Date.self {
      let _ = sdkManager.attributesBuilder.addValue(name, value: value as! Date)
    }
    
    self.tableView.reloadData()
  }
}

extension CampaignViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sdkManager.attributes.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellId")
    if indexPath.row == sdkManager.attributes.count {
      cell.textLabel?.textAlignment = .center
      cell.textLabel?.text = "Добавить аттрибут"
      cell.detailTextLabel?.text = nil
      cell.textLabel?.textColor = .gray
    } else {
      cell.textLabel?.textAlignment = .left
      cell.textLabel?.text = sdkManager.attributes[indexPath.row].attributeName
      cell.detailTextLabel?.text = "\(sdkManager.attributes[indexPath.row].attributeValue ?? "")"
      cell.textLabel?.textColor = .black
    }
    return cell
  }
}

extension CampaignViewController: UITableViewDelegate {
  private func showAddAttribute() {
    ScreenManager.presentAttribute(from: self)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showAddAttribute()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let _ = sdkManager.attributesBuilder.remove(attributeName: sdkManager.attributes[indexPath.row].attributeName)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}
