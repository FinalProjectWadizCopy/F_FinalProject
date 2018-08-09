//
//  RewardsCollectionViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 5..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class RewardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var currentAmountLabel: UILabel!
    @IBOutlet weak var totalPercentLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
