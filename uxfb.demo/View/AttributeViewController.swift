//
//  AttributeViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 26.03.2024.
//

import UIKit

protocol AttributeDelegate {
    func attributesAdded(name: String, value: any Codable)
}

class AttributeViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.layer.cornerRadius = 16
            addButton.layer.masksToBounds = true
            addButton.setTitleColor(.white, for: .normal)
            addButton.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        }
    }

    @IBOutlet weak var typeSegment: UISegmentedControl!
    
    @IBOutlet weak var boolSegment: UISegmentedControl!
    
    @IBOutlet weak var nameTextEdit: UITextField!
    
    @IBOutlet weak var textEdit: UITextField! {
        didSet {
            textEdit.delegate = self
        }
    }
    
    var delegate: AttributeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add attribute"
        addCloseButton()
    }
    
    @IBAction func backTap(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        guard let name = nameTextEdit.text, name.count > 0 else {
            return
        }
        switch typeSegment.selectedSegmentIndex {
        case 0:
            guard let value = textEdit.text, value.count > 0 else {
                return
            }
            
            delegate?.attributesAdded(name: name, value: value)
        case 1:
            guard let text = textEdit.text else {
                return
            }
            if let value = Int(text) {
                delegate?.attributesAdded(name: name, value: value)
            } else if let value = Double(text) {
                delegate?.attributesAdded(name: name, value: value)
            }
            
        case 2:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let value = textEdit.text, 
                    value.count > 0,
                  let date = dateFormatter.date(from: value) else {
                return
            }
            
            delegate?.attributesAdded(name: name, value: date)
            
        case 3:
            let value = boolSegment.selectedSegmentIndex == 0
            delegate?.attributesAdded(name: name, value: value)
            
        default:
            return
        }
        
        
        close()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        textEdit.text = ""
        switch typeSegment.selectedSegmentIndex {
        case 0:
            textEdit.isHidden = false
            textEdit.placeholder = "String attribute value"
            textEdit.keyboardType = .default
            boolSegment.isHidden = true
        case 1:
            textEdit.isHidden = false
            textEdit.placeholder = "Numeric attribute value"
            textEdit.keyboardType = .numberPad
            boolSegment.isHidden = true
        case 2:
            textEdit.isHidden = false
            textEdit.placeholder = "Date attribute value"
            boolSegment.isHidden = true
        case 3:
            textEdit.isHidden = true
            boolSegment.isHidden = false
            
        default:
            break
        }
    }
    
    @objc
    func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        textEdit.text = dateFormatter.string(from: sender.date)
    }
}

extension AttributeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if typeSegment.selectedSegmentIndex == 2 {
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePicker.Mode.date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerFromValueChanged), for: UIControl.Event.valueChanged)
            return true
        }
        
        return true
    }
}
