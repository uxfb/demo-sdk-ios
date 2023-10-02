//
//  PropertyViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class PropertyViewController: UIViewController {

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
        self.navigationItem.title = " Properties"
    }
    
    private func showPropertyAlert(index: Int) {
        let alert = UIAlertController(title: "Property", message: "Name & Value", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = index == self.sdkManager.properties.count ? "" : self.sdkManager.properties[index].name
            textField.placeholder = "Name"
        }
        
        alert.addTextField { textField in
            textField.text = index == self.sdkManager.properties.count ? "" : self.sdkManager.properties[index].value
            textField.placeholder = "Value"
        }

        alert.addAction(UIAlertAction(title: index == self.sdkManager.properties.count ? "Add" : "Save", style: .default, handler: { [weak alert] (_) in
            let nameText = alert?.textFields![0].text ?? ""
            let valueText = alert?.textFields![1].text ?? ""
            if nameText != "" && valueText != "" {
                if index == self.sdkManager.properties.count {
                    self.sdkManager.properties.append(Property(name: nameText, value: valueText))
                } else {
                    self.sdkManager.properties[index] = Property(name: nameText, value: valueText)
                }
            }
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension PropertyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdkManager.properties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellId")
        if indexPath.row == sdkManager.properties.count {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "Добавить property"
            cell.detailTextLabel?.text = nil
            cell.textLabel?.textColor = .gray
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = sdkManager.properties[indexPath.row].name
            cell.detailTextLabel?.text = sdkManager.properties[indexPath.row].value
            cell.textLabel?.textColor = .black
        }
        return cell
    }
}

extension PropertyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPropertyAlert(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sdkManager.properties.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
