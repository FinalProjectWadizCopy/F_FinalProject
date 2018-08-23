//
//  DetailRewardCollectionViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 22..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class DetailRewardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var options: UILabel!
    @IBOutlet weak var expectingDepartureDate: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var shippingCharge: UILabel!
    @IBOutlet weak var soldCount: UILabel!
    @IBOutlet weak var balanceCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
    }
    
}
