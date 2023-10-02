//
//  SettingsViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {

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

        self.navigationItem.title = "Settings"
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.backgroundColor = .clear
        
        var title = ""
        var subtitle = ""
        
        switch indexPath.section {
        case 0:
            title = "AppIds"
            subtitle = DefaultsManager.selectedAppId
            
        case 1:
            title = "SDK settings"
            subtitle = "Изменение настроек SDK"
            
        case 2:
            title = "Theme"
            subtitle = "Настройки оформления "
            
        case 3:
            title = "Properties"
            subtitle = "Дополнительные параметры"
        
        default:
            break
        }
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
            case 0:
                ScreenManager.presentAppIds(from: self) { value in
                    self.tableView.reloadData()
                }
                
            case 1:
                ScreenManager.presentSettingsSdk(from: self)
                
            case 2:
                ScreenManager.presentTheme(from: self)
                
            case 3:
                ScreenManager.presentPorperties(from: self)
            
            default:
                break
        }
    }
}
