//
//  CustomButton.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/15/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import UIKit
@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.4
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.25
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = CGSize(width: 4, height: 8)
    }
}
