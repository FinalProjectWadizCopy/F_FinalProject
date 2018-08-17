//
//  Feature_PersonalPage_ViewController.swift
//  WadizCopyProject
//
//  Created by In Tak Han on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
// 로그인 판별
// 좋아한 제품 유무 판별

class FundingPageViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    var fundingList :Bool = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
            print("viewDidLoad")
        
        collectionView.register(
            UINib(nibName: "CardCell", bundle: nil),
            forCellWithReuseIdentifier:"CardCell"
        )
        
        if fundingList { //좋아한 제품이 없는경우 컬랙션 하나만 두고
            
            
       }else { //그렇지 않고 하나 이상 있는경우 좋아한 제품을 보여준다
                //타 ViewController와 연결과정이 필요할듯..
            collectionView.isHidden = true
            let size = CGSize(width: view.frame.width / 1.7, height: 200)
            let textLable = UILabel()
            textLable.frame = CGRect(origin: CGPoint(x: view.frame.midX - (size.width / 2),
                                                     y: view.frame.midX),
                                     size: size)
//            let textLabel = UILabel(frame: CGRect(x: view.frame.midX, y: 130, width: view.frame.width / 2, height: 200))
            textLable.text = "리워드 프로젝트에 펀딩한 내역이 없습니다. 지금 바로 리워드 프로젝트를 둘러보세요!"
            textLable.numberOfLines = 3
            
            let button = UIButton()
            button.frame = CGRect(x: view.frame.midX - 100, y: 330,
                                       width: 200, height: 30)
            button.setTitle("리워드 프로젝트 가기 > ", for: UIControlState.normal)
            button.setTitleColor(UIColor.green, for: UIControlState.normal)
            button.addTarget(self, action: #selector(mainButtonAction(_:)), for: .touchUpInside)
            view.addSubview(textLable)
            view.addSubview(button)
        }
    }
    @objc func mainButtonAction(_ sender: UIButton!){
        print("메인으로 이동")
    }
}
//
extension FundingPageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        //외부에서 가져온 값을 받아오는거
        //퍼센트(이건 계산해야 될거 같네요)
        //펀딩금액, 남은 날짜, 제품설명, 브랜드명, 제품사진(썸내일), 제품종류(여러가지 등등)
        
        
        var persentLevel = Int("50")
        
        if persentLevel! >= 100 { //퍼센트에 따른 상태바 판별 100%가 넘어가면 바를 꽉채움
            cell.rewardProgress.progress = 1
        }else {
            cell.rewardProgress.progress = Float(persentLevel!) / 100
        
        }
        cell.persentLabel.text = String(persentLevel!)+"%"
        cell.rewardLabel.text = "12,345,670원"
        cell.dayLabel.text = "12일 남음"
        cell.prodectLabel.text = "펀딩 제품을 설명해 주세요 리워드 하고 싶습니다"
        cell.brandLabel.text = "브랜드명"
        
        cell.mainImage.image = UIImage(named: "dog")
        cell.proLable.text = "제품종류"
        
        return cell
    }
}
