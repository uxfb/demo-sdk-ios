//
//  ColorManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import Foundation
import UIKit

class ColorManager: NSObject {
    
    public static let shared = ColorManager()
    
    private var completion: ((UIColor) -> ())?
    
    private let picker = UIColorPickerViewController()
    
    
    public func showPicker(currentColor: UIColor, title: String, from target: UIViewController, completion: @escaping (UIColor) -> ()) {
        picker.delegate = self
        picker.supportsAlpha = false
        picker.title = title
        picker.selectedColor = currentColor
        self.completion = completion
        target.present(picker, animated: true, completion: nil)
    }
}

extension ColorManager: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        guard let completion = completion else {
            viewController.dismiss(animated: true)
            return
        }
        
        completion(viewController.selectedColor)
    }
}
