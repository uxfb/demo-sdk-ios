//
//  FontManager.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 19.04.2023.
//

import Foundation
import UIKit

class FontManager: NSObject {
    
    public static let shared = FontManager()
    
    private var completion: ((UIFont) -> ())?
    
    private let picker = UIFontPickerViewController()
    
    private var currentFontSize: CGFloat = 0
    
    public func showPicker(currentFont: UIFont, title: String, from target: UIViewController, completion: @escaping (UIFont) -> ()) {
        picker.delegate = self
        picker.title = title
        picker.selectedFontDescriptor = UIFontDescriptor(name: currentFont.fontName,
                                                         size: currentFont.pointSize)
        currentFontSize = currentFont.pointSize
        picker.configuration.includeFaces = true
        self.completion = completion
        target.present(picker, animated: true, completion: nil)
    }
}

extension FontManager: UIFontPickerViewControllerDelegate {
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        guard let completion = completion,
              let fontDescriptor = viewController.selectedFontDescriptor else {
            viewController.dismiss(animated: true)
            return
        }
        let font = UIFont(descriptor: fontDescriptor,
                          size: currentFontSize)
        
        completion(font)
        viewController.dismiss(animated: true)
    }
}
