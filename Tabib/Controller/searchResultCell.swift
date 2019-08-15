//
//  searchResultCell.swift
//  Tabib
//
//  Created by Ahmed on 8/15/19.
//  Copyright © 2019 Ahmed, ORG. All rights reserved.
//

import UIKit

class searchResultCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var ratingImgs: [UIImageView]!
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specializationLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    static let id = "searchResultCell"
    var num = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addRaduiasAndShadow()
        orderBtn.addRaduiasAndShadow()
    }
    
    @IBAction func orderBtnPressed(_ sender: UIButton) {
        print(num)
    }
    
    
}
