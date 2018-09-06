//
//  FundingSelectViewController.swift
//  WadizProject
//
//  Created by In Tak Han on 2018. 8. 21..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class FundingSelectViewController: UIViewController{
    var selectItem = false
    var selectCount = 0
    
    var selRewardPay = "65000"
    var selRewardProductType = "[얼리버드] 스팩트라 전용 백팩"
    var selRewardProductName = "3D 자세제어 장치 탑재, 인공지능 전동 스케이트보드 ‘스펙트라’"
    var selRewardDetail = "전용 팩백 40% 할인 (공식판매가 11만원)스펙트라의 휴대성을 극대화 시켜주는 아이템스펙트라 모든 모델 장착 가능"
    var selRewardShipping = "0"
    
    var selRewardDay = "2018년 10월 중순 (11~20일) 예정"
    
    var inventoryQuantity = 0
    var quantity = ""
    @IBAction func button(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addPay: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var sendPaymant: UIButton!
    
//    func noneSelectCheck(){
//        if selectCount == 0 {
//            print("최소 1개 이상의 리워드를 선택하세요")
//        }else {
//            performSegue(withIdentifier: "FundingResultView", sender: self)
//        }
//    }
    
    @IBAction func sendPaymentButton(_ sender: UIButton) {
      //  noneSelectCheck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "FundingResultView"{
            print("a")
            let fundingResultVC = segue.destination as! FundingResultViewController
            print("b")
            fundingResultVC.rewardProductName = selRewardProductType + selRewardProductName
            print("c")
            fundingResultVC.rewardDetailText = selRewardDetail
            print("d")
            fundingResultVC.rewardPay = selRewardPay
            print("e")
            fundingResultVC.rewardAddPay1 = addPay.text!
            fundingResultVC.rewardShipping = selRewardShipping
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     collectionView.frame.size = CGSize(width: view.frame.width, height: 350)
//        noneSelectCheck()
        // 배송비가 무료인지 판별하는 부분
        if selRewardShipping == "0" {
            selRewardShipping = "무료"
        }
        
        //수량 부분
        if inventoryQuantity == 0 {
            quantity = "(마감)"
        }else {
            quantity = "\(inventoryQuantity)개"
        }
        
        collectionView.register(
            UINib(nibName: "SelectRewardCell", bundle: nil), forCellWithReuseIdentifier: "SelectRewardCell"
        )
        //collectionView.delegate = self
        result.text = "제품에 \(selRewardPay)원을 펀딩합니다"
    }
}


extension FundingSelectViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection
        section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectRewardCell", for: indexPath) as! SelectRewardCell
        
        cell.fundingPay.text = selRewardPay + "원 펀딩합니다"
        cell.productType.text = selRewardProductType
        cell.productName.text = selRewardProductName + quantity
        cell.productResource.text = selRewardDetail
        cell.rewardDeliveryPay.text = "배송비: " + selRewardShipping + " 원"
        cell.rewardDays.text = selRewardDay
        return cell
    }
}

extension FundingSelectViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.collectionView.bounds.size.width),
                      height: (self.collectionView.bounds.size.height ))
    }
}
