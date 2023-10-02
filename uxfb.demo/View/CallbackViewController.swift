//
//  CallbackViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 11.09.2021.
//

import UIKit

class CallbackViewController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = .clear
        }
    }
    
    @IBOutlet var clearButton: UIButton! {
        didSet {
            clearButton.layer.cornerRadius = 16
            clearButton.layer.masksToBounds = true
            clearButton.setTitleColor(.white, for: .normal)
            clearButton.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Delegates messages"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func handleClear(_ sender: Any){
        CallbackManager.clear {
            self.tableView.reloadData()
        }
    }
}

extension CallbackViewController: UITableViewDelegate {

}

extension CallbackViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CallbackManager.getMessages().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = CallbackManager.getMessages()[indexPath.row].message
        cell.detailTextLabel?.text = CallbackManager.getMessages()[indexPath.row].datetime
        cell.detailTextLabel?.textColor = .gray
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = .clear
        return cell
    }
}
