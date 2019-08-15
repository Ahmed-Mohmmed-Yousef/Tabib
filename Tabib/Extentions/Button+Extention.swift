//
//  Button+Extention.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/11/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import UIKit

extension UIButton{
    
    func AddRoundedShadowButn(){
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = self.frame.width/2
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 4, height: 5)
    }
}
