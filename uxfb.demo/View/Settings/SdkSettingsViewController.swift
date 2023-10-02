//
//  SdkSettingsViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class SdkSettingsViewController: UIViewController {

    private let sdkManager = SdkManager.shared
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        self.navigationItem.title = "Настройки SDK"
    }
}

extension SdkSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 7
            
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: UIScreen.main.bounds.width,
                                                     height: 50)))
        view.backgroundColor = .white
        
        let label = UILabel(frame: view.frame)
        label.textAlignment = .center
        label.textColor = .gray
        view.addSubview(label)
        switch section {
        case 0:
            label.text = "EVENTS"
        case 1:
            label.text = "NETWORK"
        case 2:
            label.text = "VISUAL EFFECTS"
            
        default:
            break
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellId")
        cell.accessoryView = nil
        cell.accessoryType = .none
        cell.tintColor = .blue
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "startGlobalDelayTimer"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.globalDelayTimer )"
            case 1:
                cell.textLabel?.text = "debugEnabled"
                cell.accessoryType = sdkManager.sdk.settings.debugEnabled ? .checkmark : .none
            case 2:
                cell.textLabel?.text = "fieldsEventEnabled"
                cell.accessoryType = sdkManager.sdk.settings.fieldsEventEnabled ? .checkmark : .none
                
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "retryTimeout"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.retryTimeout)"
            case 1:
                cell.textLabel?.text = "retryCount"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.retryCount)"
            case 2:
                cell.textLabel?.text = "socketTimeout"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.socketTimeout)"
                
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "slideInUiBlocked"
                cell.accessoryType = sdkManager.sdk.settings.slideInUiBlocked ? .checkmark : .none
            case 1:
                cell.textLabel?.text = "slideInUiBlackoutColor"
                var hexColor = "#\(sdkManager.sdk.settings.slideInUiBlackoutColor ?? "")"
                hexColor = hexColor.replacingOccurrences(of: "##", with: "#", options: .caseInsensitive)
                cell.detailTextLabel?.text = hexColor
                let colorView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40,
                                                                                 height: 40)))
                
                colorView.layer.borderColor = UIColor.lightGray.cgColor
                colorView.layer.borderWidth = 1
                colorView.layer.cornerRadius = 2
                colorView.layer.masksToBounds = true
                cell.accessoryView = colorView
                
                colorView.backgroundColor = UIColor.init(hexColor)
                
                
                
            case 2:
                cell.textLabel?.text = "slideInUiBlackoutOpacity"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.slideInUiBlackoutOpacity ?? 0)"
            case 3:
                cell.textLabel?.text = "slideInUiBlackoutBlur"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.slideInUiBlackoutBlur ?? 0)"
            case 4:
                cell.textLabel?.text = "popupUiBlackoutColor"
                var hexColor = "#\(sdkManager.sdk.settings.popupUiBlackoutColor ?? "")"
                hexColor = hexColor.replacingOccurrences(of: "##", with: "#", options: .caseInsensitive)
                cell.detailTextLabel?.text = hexColor
                let colorView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40,
                                                                                 height: 40)))
                
                colorView.layer.borderColor = UIColor.lightGray.cgColor
                colorView.layer.borderWidth = 1
                colorView.layer.cornerRadius = 2
                colorView.layer.masksToBounds = true
                
                colorView.backgroundColor = UIColor.init(hexColor)
                
                cell.accessoryView = colorView
                
            case 5:
                cell.textLabel?.text = "popupUiBlackoutOpacity"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.popupUiBlackoutOpacity ?? 0)"
            case 6:
                cell.textLabel?.text = "popupUiBlackoutBlur"
                cell.detailTextLabel?.text = "\(sdkManager.sdk.settings.popupUiBlackoutBlur ?? 0)"
                
            default:
                break
            }
            
        default:
            break
        }

        return cell
    }
}


extension SdkSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                AlertManager().showInput(from: self, title: "Delay", message: "Delay in seconds", value: "\(self.sdkManager.sdk.settings.globalDelayTimer)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.globalDelayTimer = Int(value) ?? 0
                    self.tableView.reloadData()
                }
                
            case 1:
                sdkManager.sdk.settings.debugEnabled = !sdkManager.sdk.settings.debugEnabled
                self.tableView.reloadData()
            case 2:
                sdkManager.sdk.settings.fieldsEventEnabled = !sdkManager.sdk.settings.fieldsEventEnabled
                self.tableView.reloadData()
                
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                AlertManager().showInput(from: self, title: "Retry timeout", message: "Timeout to next retry", value: "\(self.sdkManager.sdk.settings.retryTimeout)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.retryTimeout = Double(value) ?? 0
                    self.tableView.reloadData()
                }
                
            case 1:
                AlertManager().showInput(from: self, title: "Retry count", message: "Retries count ", value: "\(self.sdkManager.sdk.settings.retryCount)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.retryCount = Int(value) ?? 0
                    self.tableView.reloadData()
                }
                
            case 2:
                AlertManager().showInput(from: self, title: "Network timeout", message: "Timeout for each request", value: "\(sdkManager.sdk.settings.socketTimeout)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.socketTimeout = Double(value) ?? 0
                    self.tableView.reloadData()
                }
                
            default:
                break
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                sdkManager.sdk.settings.slideInUiBlocked = !sdkManager.sdk.settings.slideInUiBlocked
                tableView.reloadData()
            case 1:
                let color = UIColor(hex: self.sdkManager.sdk.settings.slideInUiBlackoutColor ?? "") ?? .clear
                ColorManager.shared.showPicker(currentColor: color,
                                               title: "slideInUiBlackoutColor",
                                               from: self) { color in

                    let hexColor = color == .clear ? "" : color.hexString()
                    self.sdkManager.sdk.settings.slideInUiBlackoutColor = hexColor
                    self.tableView.reloadData()
                }
                
            case 2:
                AlertManager().showInput(from: self, title: "Opacity", message: "Value of opacity from 0 to 100", value: "\(self.sdkManager.sdk.settings.slideInUiBlackoutOpacity ?? 0)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.slideInUiBlackoutOpacity = Int(value) ?? 0
                    self.tableView.reloadData()
                }
                
            case 3:
                AlertManager().showInput(from: self,title: "Blur", message: "Value of blur from 0 to 100", value: "\(self.sdkManager.sdk.settings.slideInUiBlackoutBlur ?? 0)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.slideInUiBlackoutBlur = Int(value) ?? 0
                    self.tableView.reloadData()
                }
                
            case 4:
                let color = UIColor(hex: self.sdkManager.sdk.settings.popupUiBlackoutColor ?? "") ?? .clear
                ColorManager.shared.showPicker(currentColor: color,
                                               title: "popupUiBlackoutColor",
                                               from: self) { color in
                    let hexColor = color == .clear ? "" : color.hexString()
                    self.sdkManager.sdk.settings.popupUiBlackoutColor = hexColor
                    self.tableView.reloadData()
                }
                
            case 5:
                AlertManager().showInput(from: self, title: "Opacity", message: "Value of opacity from 0 to 100", value: "\(self.sdkManager.sdk.settings.popupUiBlackoutOpacity ?? 0)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.popupUiBlackoutOpacity = Int(value) ?? 0
                    self.tableView.reloadData()}
                
            case 6:
                AlertManager().showInput(from: self,title: "Blur", message: "Value of blur from 0 to 100", value: "\(self.sdkManager.sdk.settings.popupUiBlackoutBlur ?? 0)", keyboardType: .numberPad) { value in
                    self.sdkManager.sdk.settings.popupUiBlackoutBlur = Int(value) ?? 0
                    self.tableView.reloadData()
                }
                
                
            default:
                break
            }
            
        default:
            break
        }
    }
        
}
