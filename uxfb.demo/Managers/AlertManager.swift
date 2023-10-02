//
//  AlertManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

typealias Action = () -> ()
typealias SheetAction = (String, Action)

class AlertManager: NSObject {
    public func showInput(from: UIViewController, title: String, message: String, value: String, keyboardType: UIKeyboardType, completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = value
            textField.placeholder = title
            textField.keyboardType = keyboardType
        }

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let valueText = alert?.textFields![0].text ?? ""
            if valueText != "" {
                completion(valueText)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        from.present(alert, animated: true, completion: nil)
    }
    
    public func showSheet(from: UIViewController, title: String, message: String, actions: [SheetAction] ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.0, style: .default) { alertAction in
                action.1()
            }
            alert.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
        alert.addAction(cancelAction)
        
        from.present(alert, animated: true, completion: nil)
    }
}
