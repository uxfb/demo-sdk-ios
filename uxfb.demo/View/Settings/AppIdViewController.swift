//
//  AppIdViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class AppIdViewController: UIViewController {
    var completion: ((String) -> ())?
    
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
        self.navigationItem.title = "App Ids"
    }
}

extension AppIdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DefaultsManager.appIds.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == DefaultsManager.appIds.count {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "Добавить AppId"
            cell.textLabel?.textColor = .gray
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = DefaultsManager.appIds[indexPath.row]
            cell.textLabel?.textColor = .black
        }
        return cell
    }
}

extension AppIdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == DefaultsManager.appIds.count {
            AlertManager().showInput(from: self,
                                   title: "AppId",
                                   message: "UXFeedback application ID",
                                   value: "",
                                   keyboardType: .default) { value in
                var ids = DefaultsManager.appIds
                ids.append(value)
                DefaultsManager.appIds = ids
                
                self.tableView.reloadData()
            }
        } else {
            DefaultsManager.selectedAppId = DefaultsManager.appIds[indexPath.row]
            SdkManager.shared.reloadCampaign()
            completion?(DefaultsManager.selectedAppId)
            self.dismiss(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          var ids = DefaultsManager.appIds
          ids.remove(at: indexPath.row)
          DefaultsManager.appIds = ids
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
