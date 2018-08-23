//
//  RewardHeaderCollectionViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class RewardHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var projectSearch: UITextField!
    @IBOutlet weak var viewMode: UIButton!
    
    @IBAction func sortMode(_ sender: UIButton) {
        print("sordMode UP")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
