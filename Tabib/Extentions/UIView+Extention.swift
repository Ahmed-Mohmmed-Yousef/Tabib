//
//  UIView+Extention.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/12/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import UIKit

extension UIView {
    
    func addRaduiasAndShadow(){
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.4
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 4, height: 5)
    }
    
}
