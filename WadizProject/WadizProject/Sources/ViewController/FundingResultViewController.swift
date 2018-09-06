//
//  FundingResultViewController.swift
//  WadizProject
//
//  Created by In Tak Han on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class FundingResultViewController: UIViewController {

    //펀딩기본 정보 부분 리워드명, 상세정보, 수량 및 가격, 추가후원금, 배송비
    @IBOutlet weak var rewardName: UILabel!
    @IBOutlet weak var rewardDetail: UILabel!
    @IBOutlet weak var rewardQuantityPay: UILabel!
    @IBOutlet weak var rewardAddPay: UILabel!
    @IBOutlet weak var shippingPay: UILabel!
    
    //최종 금액 부분
    @IBOutlet weak var finalPay: UILabel!
    @IBOutlet weak var addFinalPay: UILabel!
    @IBOutlet weak var finalSippingPay: UILabel!
    @IBOutlet weak var totalPay: UILabel!
    
    //배송 정보입력 부분 이름, 휴대폰 번호, 주소, 요청사항 순
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputPhone: UITextField!
    @IBAction func inputAddress1(_ sender: UIButton) {
        
    }
    @IBOutlet weak var inputAddress2: UITextField!
    @IBOutlet weak var shippingMemo: UITextField!
    
    //결제정보 입력 부분 카드번호, 유효기간, 카드비번, 개인 생년월일 순
    @IBOutlet weak var card1: UITextField!
    @IBOutlet weak var card2: UITextField!
    @IBOutlet weak var card3: UITextField!
    @IBOutlet weak var card4: UITextField!
    @IBOutlet weak var cardValidity: UITextField!
    @IBOutlet weak var cardPassword: UITextField!
    @IBOutlet weak var brith: UITextField!
    
    //
    @IBOutlet weak var termsPay: UIButton!
    @IBOutlet weak var termsInfo: UIButton!
    @IBOutlet weak var termsRegulations: UIButton!
    
    var payCheckSelected = true
    var infoCheckSelected = true
    var regulationsSelected = true
    
    let checkedImage: UIImage = UIImage(named: "checked-1")!
    let nonCheckedImage: UIImage = UIImage(named: "noneChecked")!
    
    //약관 선택 판별부분
    func payCheck(){
        if payCheckSelected == false{
            termsPay.setImage(checkedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            payCheckSelected = true
        }else {
            termsPay.setImage(nonCheckedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            payCheckSelected = false
        }
    }
    func infoCheck(){
        if infoCheckSelected == false {
            termsInfo.setImage(checkedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            infoCheckSelected = true
        }else {
            termsInfo.setImage(nonCheckedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            infoCheckSelected = false
        }
    }
    
    func regulationsCheck(){
        if regulationsSelected == false {
            termsRegulations.setImage(checkedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            regulationsSelected = true
        }else {
            termsRegulations.setImage(nonCheckedImage.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
            regulationsSelected = false
        }
    }
    //약관 구현 부분
    @IBAction func payCheckBtn(_ sender: UIButton){
        payCheck()
    }
    @IBAction func infoChecBtn(_ sender: UIButton){
        infoCheck()
    }
    @IBAction func regulationsCheckBtn(_ sender: UIButton){
        regulationsCheck()
    }
    
    //약관 동의해야 다음뷰로 넘어가고 그렇지 않으면 알림창 열 수있게 하기
    let rewards = PostService()
    
    func termsSelect(){
        if payCheckSelected == true && infoCheckSelected == true && regulationsSelected == true {
            let alerController = UIAlertController(title: nil, message: "펀딩 완료", preferredStyle: .alert)
            let alert = UIAlertAction(title: "확 인", style: .default) { (action) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainView") as! MainViewController
                self.rewards.rewardGetList { (reward) in
                    vc.rewardsResults = reward.results
                    API.nextURL = reward.next!
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
            alerController.addAction(alert)
            present(alerController, animated: true, completion: nil)
        }else {
            print("경고: 약관에 동의하셔야 결제 예약이 가능합니다")
           //경고 팝업 생성
            let alert = UIAlertView()
//            alert.title = "버튼 타이틀입니다."
            alert.message = "약관에 동의하셔야 \n결제 예약이 가능합니다."
            alert.addButton(withTitle: "확인")
            alert.show()
        }
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
       termsSelect()
    }
    
    
    var rewardPay = ""
    var rewardProductType = ""
    var rewardProductName = ""
    var rewardDetailText = ""
    var rewardAddPay1 = ""
    var rewardShipping = ""
    var rewardDay = ""
    
    @IBAction func button(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if rewardShipping == "무료" {
            rewardShipping = "0"
        } //최종값 계산할때 오류나기 때문에 다시 숫자로 변환
        
        //제품이름, 상세정보, 수량 및 기격, 추가금액, 배송비를 보여줌
        rewardName.text = rewardProductName
        rewardDetail.text = rewardDetailText
        rewardQuantityPay.text = "수량 1개 \t \(rewardPay) 원"
        rewardAddPay.text = rewardAddPay1 + " 원"
        shippingPay.text = rewardShipping + " 원"
        
        
        //최종 금액
        finalPay.text = rewardPay + " 원"
        addFinalPay.text = rewardAddPay1 + " 원"
        finalSippingPay.text = rewardShipping + " 원"
        
        totalPay.text = "\(Int(rewardPay)! + Int( rewardAddPay1)! + Int(rewardShipping)!) 원"
        

        
        termsPay.titleLabel?.lineBreakMode = .byWordWrapping
        termsPay.setTitle("본인은 위 리워드 서비스 결제 및 취소와 환불규정 등의 주의 사항을 \n모두 읽어 보았으며 이에 동의합니다", for: UIControlState.normal)
        payCheck()
        infoCheck()
        regulationsCheck()
        
        //termsSelect()
    }
}
