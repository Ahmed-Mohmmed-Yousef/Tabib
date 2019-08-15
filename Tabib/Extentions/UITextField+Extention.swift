//
//  UITextField+Extention.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/11/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import UIKit
extension UITextField{
    var hasValue: Bool{
        guard text == "" else{
            leftView = nil
            return true
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageView.image = #imageLiteral(resourceName: "warning")
        contentMode = .scaleAspectFit
        leftView = imageView
        leftViewMode = .unlessEditing
//        layer.borderColor = UIColor.red.cgColor
//        layer.borderWidth = 1
//        layer.cornerRadius = 5
        
        return false
    }
    
    /// Add Icon to text field
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 0, y: 0, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    /// add done buttn
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        if let dlgt = delegate, let  ret = dlgt.textFieldShouldReturn?(self){
            if ret{
                self.resignFirstResponder()
            }
        }
        
    }
}
