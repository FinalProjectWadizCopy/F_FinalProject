//
//  FundingTermsViewController.swift
//  WadizCopyProject
//
//  Created by In Tak Han on 2018. 8. 16..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class FundingTermsViewController: UIViewController {

    var paySelected = true
    var endDaySelected = true
    var sendRewardSelected = true
    
    let checkImage: UIImage = UIImage(named: "checked.png")!
    let noneCheckImage: UIImage = UIImage(named: "nChecked.png")!
    
    @IBAction func returnDetailButton(_ sender: UIButton) {
        print("이전 페이지로")
    }
    
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var endDayButton: UIButton!
    @IBOutlet weak var sendRewardButton: UIButton!
    @IBOutlet public weak var fundingButton: UIButton!
    
    @IBAction func payCheckButton(_ sender: UIButton){
        payCheck()
    }
    @IBAction func endDayCheckButton(_ sender: UIButton){
       endDayCheck()
    }
    @IBAction func sendRewardCheckButton(_ sender: UIButton){
        sendRewardCheck()
    }
    
    func payCheck(){
        if paySelected == false {
            paymentButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            paymentButton.setTitleColor(UIColor(red: 125/255.0, green: 130/255.0, blue: 135/255.0, alpha: 1), for: UIControlState.normal)
            paySelected = true
           
        }else {
            paymentButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            paymentButton.setTitleColor(UIColor(red: 187/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1), for: UIControlState.normal)
            paySelected = false
          
        }
        btnSelected()
    }
    func endDayCheck(){
        if endDaySelected == false {
            endDayButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            endDayButton.setTitleColor(UIColor(red: 125/255.0, green: 130/255.0, blue: 135/255.0, alpha: 1), for: UIControlState.normal)
            endDaySelected = true
           
        }else {
            endDayButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            endDayButton.setTitleColor(UIColor(red: 187/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1), for: UIControlState.normal)
            endDaySelected = false
        }
        btnSelected()
    }
    func sendRewardCheck(){
        if sendRewardSelected == false {
            sendRewardButton.setImage(checkImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            sendRewardButton.setTitleColor(UIColor(red: 125/255.0, green: 130/255.0, blue: 135/255.0, alpha: 1), for: UIControlState.normal)
            sendRewardSelected = true
        }else {
            sendRewardButton.setImage(noneCheckImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            sendRewardButton.setTitleColor(UIColor(red: 187/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1), for: UIControlState.normal)
            sendRewardSelected = false
        }
        btnSelected()
    }
    
    //펀딩하기 버튼 활성화부분 (위 3개의 버튼 항목이 모두 선택 되어야 활성화 되게 만듬)
    func btnSelected( ){
        if paySelected == true && endDaySelected == true  && sendRewardSelected == true {
            fundingButton.isEnabled = true
            fundingButton.backgroundColor = UIColor(red: 92/255.0, green: 201/255.0, blue: 165/255.0, alpha: 1)
            print("selected")
        }else {
            fundingButton.isEnabled = false
            fundingButton.backgroundColor = UIColor(red: 231/255.0, green: 234/255.0, blue: 237/255.0, alpha: 1)
            print("nselected")
        }
        
    }
    
    @IBAction func fundingActionButton(_ sender: UIButton){ 
       print("결제페이지로 이동")
    }
    @IBOutlet weak var payText: UILabel!
    @IBOutlet weak var endDayText: UILabel!
    @IBOutlet weak var sendRewardText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payCheck()
        payText.text = "지금 펀딩하시면 결제 예약되며, 목표금액 달성 시,\n2018.09.10에 모두 함께 결제됩니다"
//        payText.layer.borderColor! = UIColor.darkGray.cgColor
        endDayCheck()
        endDayText.text = "리워드 결제 예약 취소와 변경은 프로젝트 펀딩기간 중에만 가능합니다.\n펀딩 취소는 2018.09.16까지 가능합니다. 이후로는 취소가 불가합니다."
        sendRewardText.text = "리워드는 메이커가 약속한 날짜에 발송됩니다.\n선택한 리워드의 발송 예정일을 확인한 후에 펀딩해 주세요.\n\n- 리워드 펀딩 특성상 발송이 지연되거나 불가할 수 있습니다.\n- 펀딩 안내 탭의 리워드 발송 예상 변동 기간 및 교환, 환불, AS 정책을 참고해주세요.\n- 기부 • 후원인 경우, 리워드가 발송되지 않습니다."
        sendRewardCheck()
        btnSelected()
    }
}

