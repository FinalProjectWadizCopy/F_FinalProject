//
//  FundingTermsViewController.swift
//  WadizCopyProject
//
//  Created by In Tak Han on 2018. 8. 16..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class FundingTermsViewController: UIViewController {

    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var fundingButton: UIButton!
    @IBOutlet weak var payText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        paymentButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        paymentButton.isEnabled = true
        payText.text = "지금 펀딩하시면 결제 예약되며, 목표금액 달성 시,\n2018.09.10에 모두 함께 결제됩니다"
        payText.layer.borderColor! = UIColor.darkGray.cgColor
        
        if paymentButton.isEnabled == false {
            fundingButton.isEnabled = false
            fundingButton.backgroundColor = UIColor.gray
        }
        
    }
    @IBAction func checkButton(_ sender: UIButton){
            paymentButton.isEnabled = false
        
    }

}
