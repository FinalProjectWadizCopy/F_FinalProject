//
//  MenuCollectionViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 3..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

@IBDesignable
class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryCellButton: UIButton!
    @IBOutlet weak var categoryCellTitle: UILabel!

    override func awakeFromNib() {
        categoryCellButton.layer.cornerRadius = categoryCellButton.frame.height / 2
        categoryCellButton.layer.masksToBounds = true
    }
}
