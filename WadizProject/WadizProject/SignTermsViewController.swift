//
//  TermsViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 17..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class SignTermsViewController: UIViewController {
    
    var all = true
    var need = true
    var select = true
    
    let checkImage: UIImage = UIImage(named: "checked.png")!
    let noneCheckImage: UIImage = UIImage(named: "nChecked.png")!
    
    @IBOutlet weak var allCheckButton: UIButton!
    @IBOutlet weak var needCheckButton: UIButton!
    @IBOutlet weak var selectCheckButton: UIButton!
    @IBOutlet public weak var doneButton: UIButton!
    
    
    @IBAction func allButton(_ sender: UIButton) {
        allCheck()
    }
    

    @IBAction func needButton(_ sender: UIButton) {
        needCheck()
    }
    
    @IBAction func selectButton(_ sender: UIButton) {
        selectCheck()
    }
    
    @IBAction func done2Button(_ sender: UIButton){
    }
    func allCheck(){
        if all == false {
            allCheckButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            allCheckButton.setTitleColor(UIColor.green, for: UIControlState.normal)
            all = true
            
        }else {
            allCheckButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            allCheckButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            all = false
            
        }
        btnSelected()
    }
    func needCheck(){
        if need == false {
            needCheckButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            needCheckButton.setTitleColor(UIColor.green, for: UIControlState.normal)
            need = true
            
        }else {
            needCheckButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            needCheckButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            need = false
        }
        btnSelected()
    }
    func selectCheck(){
        if select == false {
            selectCheckButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            selectCheckButton.setTitleColor(UIColor.green, for: UIControlState.normal)
            select = true
        }else {
            selectCheckButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            selectCheckButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
            select = false
        }
        btnSelected()
    }
    
    func btnSelected( ){
        if all == true && need == true  && select == true {
            doneButton.isEnabled = true
            doneButton.backgroundColor = UIColor.green
            print("selected")
        }else {
            doneButton.isEnabled = false
            doneButton.backgroundColor = UIColor.gray
            print("nselected")
        }
    }

    @IBOutlet weak var allText: UILabel!
    @IBOutlet weak var needText: UILabel!
    @IBOutlet weak var selectText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCheck()
        allText.text = "전체 동의"
        //        payText.layer.borderColor! = UIColor.darkGray.cgColor
        needCheck()
        needText.text = "와디즈 서비스 이용약관(필수)"
        selectText.text = "쿠폰, 포인트, 오픈알림, 뉴스테러 수신(선택)"
        selectCheck()
        btnSelected()
    }
}




    



