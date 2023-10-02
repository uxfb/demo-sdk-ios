//
//  ThemeViewController.swift
//  uxfeedback.demo
//
//  Created by Alexander Potemka on 18.03.2023.
//

import UIKit

class ThemeViewController: UIViewController {
    
    private let sdkManager = SdkManager.shared

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = .clear
            tableView.separatorInset = UIEdgeInsets(top: 0,
                                                    left: 16,
                                                    bottom: 0,
                                                    right: 64)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        self.navigationItem.title = "Настройки темы"
    }
}

extension ThemeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 23
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellId")
        
        let colorView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40,
                                                                         height: 40)))
        
        colorView.layer.borderColor = UIColor.lightGray.cgColor
        colorView.layer.borderWidth = 1
        colorView.layer.cornerRadius = 2
        colorView.layer.masksToBounds = true
        
        cell.accessoryView = colorView
        
        var elementName = ""
        var elementValue = ""

        switch indexPath.row {
        case 0:
            elementName = "bgColor"
            elementValue = sdkManager.theme.bgColor.hexString()
            colorView.backgroundColor = sdkManager.theme.bgColor
            
        case 1:
            elementName = "iconColor"
            elementValue = sdkManager.theme.iconColor.hexString()
            colorView.backgroundColor = sdkManager.theme.iconColor
            
        case 2:
            elementName = "text01Color"
            elementValue = sdkManager.theme.text01Color.hexString()
            colorView.backgroundColor = sdkManager.theme.text01Color
            
        case 3:
            elementName = "text02Color"
            elementValue = sdkManager.theme.text02Color.hexString()
            colorView.backgroundColor = sdkManager.theme.text02Color
            
        case 4:
            elementName = "text03Color"
            elementValue = sdkManager.theme.text03Color.hexString()
            colorView.backgroundColor = sdkManager.theme.text03Color
            
        case 5:
            elementName = "mainColor"
            elementValue = sdkManager.theme.mainColor.hexString()
            colorView.backgroundColor = sdkManager.theme.mainColor
            
        case 6:
            elementName = "errorColorPrimary"
            elementValue = sdkManager.theme.errorColorPrimary.hexString()
            colorView.backgroundColor = sdkManager.theme.errorColorPrimary
            
        case 7:
            elementName = "errorColorSecondary"
            elementValue = sdkManager.theme.errorColorSecondary.hexString()
            colorView.backgroundColor = sdkManager.theme.errorColorSecondary
            
        case 8:
            elementName = "btnBgColor"
            elementValue = sdkManager.theme.btnBgColor.hexString()
            colorView.backgroundColor = sdkManager.theme.btnBgColor
            
        case 9:
            elementName = "btnBgColorActive"
            elementValue = sdkManager.theme.btnBgColorActive.hexString()
            colorView.backgroundColor = sdkManager.theme.btnBgColorActive
            
        case 10:
            elementName = "btnTextColor"
            elementValue = sdkManager.theme.btnTextColor.hexString()
            colorView.backgroundColor = sdkManager.theme.btnTextColor
            
        case 11:
            elementName = "inputBgColor"
            elementValue = sdkManager.theme.inputBgColor.hexString()
            colorView.backgroundColor = sdkManager.theme.inputBgColor
            
        case 12:
            elementName = "inputBorderColor"
            elementValue = sdkManager.theme.inputBorderColor.hexString()
            colorView.backgroundColor = sdkManager.theme.inputBorderColor
            
        case 13:
            elementName = "controlBgColor"
            elementValue = sdkManager.theme.controlBgColor.hexString()
            colorView.backgroundColor = sdkManager.theme.controlBgColor
            
        case 14:
            elementName = "controlBgColorActive"
            elementValue = sdkManager.theme.controlBgColorActive.hexString()
            colorView.backgroundColor = sdkManager.theme.controlBgColorActive
            
        case 15:
            elementName = "controlIconColor"
            elementValue = sdkManager.theme.controlIconColor.hexString()
            colorView.backgroundColor = sdkManager.theme.controlIconColor
            
        case 16:
            elementName = "formBorderRadius"
            elementValue = "\(sdkManager.theme.formBorderRadius)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 17:
            elementName = "btnBorderRadius"
            elementValue = "\(sdkManager.theme.btnBorderRadius)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 18:
            elementName = "fontH1"
            elementValue = "\(sdkManager.theme.fontH1.fontName) - \(sdkManager.theme.fontH1.pointSize)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 19:
            elementName = "fontH2"
            elementValue = "\(sdkManager.theme.fontH2.fontName) - \(sdkManager.theme.fontH2.pointSize)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 20:
            elementName = "fontP1"
            elementValue = "\(sdkManager.theme.fontP1.fontName) - \(sdkManager.theme.fontP1.pointSize)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 21:
            elementName = "fontP2"
            elementValue = "\(sdkManager.theme.fontP2.fontName) - \(sdkManager.theme.fontP2.pointSize)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        case 22:
            elementName = "fontBtn"
            elementValue = "\(sdkManager.theme.fontBtn.fontName) - \(sdkManager.theme.fontBtn.pointSize)"
            colorView.backgroundColor = .clear
            colorView.layer.borderWidth = 0
            
        default:
            break
        }
        
        cell.textLabel?.text = elementName
        cell.detailTextLabel?.text = elementValue
        return cell
    }
}

extension ThemeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.bgColor, title: "bgColor", from: self) { color in
                self.sdkManager.theme.bgColor = color
                self.tableView.reloadData()
            }
        case 1:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.iconColor, title: "iconColor", from: self) { color in
                self.sdkManager.theme.iconColor = color
                self.tableView.reloadData()
            }
        case 2:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.text01Color, title: "text01Color", from: self) { color in
                self.sdkManager.theme.text01Color = color
                self.tableView.reloadData()
            }
        case 3:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.text02Color, title: "text02Color", from: self) { color in
                self.sdkManager.theme.text02Color = color
                self.tableView.reloadData()
            }
        case 4:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.text03Color, title: "text03Color", from: self) { color in
                self.sdkManager.theme.text03Color = color
                self.tableView.reloadData()
            }
        case 5:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.mainColor, title: "mainColor", from: self) { color in
                self.sdkManager.theme.mainColor = color
                self.tableView.reloadData()
            }
        case 6:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.errorColorPrimary, title: "errorColorPrimary", from: self) { color in
                self.sdkManager.theme.errorColorPrimary = color
                self.tableView.reloadData()
            }
        case 7:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.errorColorSecondary, title: "errorColorSecondary", from: self) { color in
                self.sdkManager.theme.errorColorSecondary = color
                self.tableView.reloadData()
            }
        case 8:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.btnBgColor, title: "btnBgColor", from: self) { color in
                self.sdkManager.theme.btnBgColor = color
                self.tableView.reloadData()
            }
        case 9:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.btnBgColorActive, title: "btnBgColorActive", from: self) { color in
                self.sdkManager.theme.btnBgColorActive = color
                self.tableView.reloadData()
            }
        case 10:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.btnTextColor, title: "btnTextColor", from: self) { color in
                self.sdkManager.theme.btnTextColor = color
                self.tableView.reloadData()
            }
        case 11:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.inputBgColor, title: "inputBgColor", from: self) { color in
                self.sdkManager.theme.inputBgColor = color
                self.tableView.reloadData()
            }
        case 12:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.inputBorderColor, title: "inputBorderColor", from: self) { color in
                self.sdkManager.theme.inputBorderColor = color
                self.tableView.reloadData()
            }
        case 13:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.controlBgColor, title: "controlBgColor", from: self) { color in
                self.sdkManager.theme.controlBgColor = color
                self.tableView.reloadData()
            }
        case 14:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.controlBgColorActive, title: "controlBgColorActive", from: self) { color in
                self.sdkManager.theme.controlBgColorActive = color
                self.tableView.reloadData()
            }
        case 15:
            ColorManager.shared.showPicker(currentColor: self.sdkManager.theme.controlIconColor, title: "controlIconColor", from: self) { color in
                self.sdkManager.theme.controlIconColor = color
                self.tableView.reloadData()
            }
        case 16:
            AlertManager().showInput(from: self, title: "btnBorderRadius", message: "", value: "\(sdkManager.theme.formBorderRadius)", keyboardType: .numberPad) { value in
                self.sdkManager.theme.formBorderRadius = CGFloat(Float(value) ?? 0)
                self.tableView.reloadData()
            }
            
        case 17:
            AlertManager().showInput(from: self, title: "btnBorderRadius", message: "", value: "\(sdkManager.theme.btnBorderRadius)", keyboardType: .numberPad) { value in
                self.sdkManager.theme.btnBorderRadius = CGFloat(Float(value) ?? 0)
                self.tableView.reloadData()
            }
            
        case 18:
            let actionFont = {
                FontManager.shared.showPicker(currentFont: self.sdkManager.theme.fontH1,
                                              title: "fontH1",
                                              from: self) { font in
                    self.sdkManager.theme.fontH1 = font
                    self.tableView.reloadData()
                }
            }
            let actionSize = {
                AlertManager().showInput(from: self,
                                         title: "fontH1",
                                         message: "size of font",
                                         value: "\(self.sdkManager.theme.fontH1.pointSize)",
                                         keyboardType: .numberPad) { value in
                    self.sdkManager.theme.fontH1 = self.sdkManager.theme.fontH1.withSize(CGFloat(Float(value) ?? 0))
                    self.tableView.reloadData()
                }
            }
            let actions: [SheetAction] = [SheetAction("Шрифт",actionFont), SheetAction("Размер",actionSize)]
            AlertManager().showSheet(from: self,
                                     title: "fontH1",
                                     message: "",
                                     actions: actions)
        case 19:
            let actionFont = {
                FontManager.shared.showPicker(currentFont: self.sdkManager.theme.fontH2,
                                              title: "fontH2",
                                              from: self) { font in
                    self.sdkManager.theme.fontH2 = font
                    self.tableView.reloadData()
                }
            }
            let actionSize = {
                AlertManager().showInput(from: self,
                                         title: "fontH2",
                                         message: "size of font",
                                         value: "\(self.sdkManager.theme.fontH2.pointSize)",
                                         keyboardType: .numberPad) { value in
                    self.sdkManager.theme.fontH2 = self.sdkManager.theme.fontH2.withSize(CGFloat(Float(value) ?? 0))
                    self.tableView.reloadData()
                }
            }
            let actions: [SheetAction] = [SheetAction("Шрифт",actionFont), SheetAction("Размер",actionSize)]
            AlertManager().showSheet(from: self,
                                     title: "fontH2",
                                     message: "",
                                     actions: actions)
        case 20:
            let actionFont = {
                FontManager.shared.showPicker(currentFont: self.sdkManager.theme.fontP1,
                                              title: "fontP1",
                                              from: self) { font in
                    self.sdkManager.theme.fontP1 = font
                    self.tableView.reloadData()
                }
            }
            let actionSize = {
                AlertManager().showInput(from: self,
                                         title: "fontP1",
                                         message: "size of font",
                                         value: "\(self.sdkManager.theme.fontP1.pointSize)",
                                         keyboardType: .numberPad) { value in
                    self.sdkManager.theme.fontP1 = self.sdkManager.theme.fontP1.withSize(CGFloat(Float(value) ?? 0))
                    self.tableView.reloadData()
                }
            }
            let actions: [SheetAction] = [SheetAction("Шрифт",actionFont), SheetAction("Размер",actionSize)]
            AlertManager().showSheet(from: self,
                                     title: "fontP1",
                                     message: "",
                                     actions: actions)
        case 21:
            let actionFont = {
                FontManager.shared.showPicker(currentFont: self.sdkManager.theme.fontP2,
                                              title: "fontP2",
                                              from: self) { font in
                    self.sdkManager.theme.fontP2 = font
                    self.tableView.reloadData()
                }
            }
            let actionSize = {
                AlertManager().showInput(from: self,
                                         title: "fontP2",
                                         message: "size of font",
                                         value: "\(self.sdkManager.theme.fontP2.pointSize)",
                                         keyboardType: .numberPad) { value in
                    self.sdkManager.theme.fontP2 = self.sdkManager.theme.fontP2.withSize(CGFloat(Float(value) ?? 0))
                    self.tableView.reloadData()
                }
            }
            let actions: [SheetAction] = [SheetAction("Шрифт",actionFont), SheetAction("Размер",actionSize)]
            AlertManager().showSheet(from: self,
                                     title: "fontP2",
                                     message: "",
                                     actions: actions)
        case 22:
            let actionFont = {
                FontManager.shared.showPicker(currentFont: self.sdkManager.theme.fontBtn,
                                              title: "fontBtn",
                                              from: self) { font in
                    self.sdkManager.theme.fontBtn = font
                    self.tableView.reloadData()
                }
            }
            let actionSize = {
                AlertManager().showInput(from: self,
                                         title: "fontBtn",
                                         message: "size of font",
                                         value: "\(self.sdkManager.theme.fontBtn.pointSize)",
                                         keyboardType: .numberPad) { value in
                    self.sdkManager.theme.fontBtn = self.sdkManager.theme.fontBtn.withSize(CGFloat(Float(value) ?? 0))
                    self.tableView.reloadData()
                }
            }
            let actions: [SheetAction] = [SheetAction("Шрифт",actionFont), SheetAction("Размер",actionSize)]
            AlertManager().showSheet(from: self,
                                     title: "fontBtn",
                                     message: "",
                                     actions: actions)
            
        default:
            break
        }
    }
}
