//
//  Feature_PersonalPage_ViewController.swift
//  WadizCopyProject
//
//  Created by In Tak Han on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class FundingPageViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var fundinglist: [UserInfo.FundingSet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: "FundingListCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier:"FundingList"
        )
        if !fundinglist.isEmpty { //좋아한 제품이 없는경우 컬랙션 하나만 두고
            collectionView.isHidden = false
        }else {
            collectionView.isHidden = true
            let size = CGSize(width: view.frame.width / 1.7, height: 200)
            let textLable = UILabel()
            textLable.frame = CGRect(origin: CGPoint(x: view.frame.midX - (size.width / 2),
                                                     y: view.frame.midX),
                                     size: size)
            textLable.text = "리워드 프로젝트에 펀딩한 내역이 없습니다. 지금 바로 리워드 프로젝트를 둘러보세요!"
            textLable.numberOfLines = 3
            view.addSubview(textLable)
        }
    }
    
}
//
extension FundingPageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fundinglist.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FundingList", for: indexPath) as! FundingListCollectionViewCell
        let product = fundinglist[indexPath.row].reward.product
        let order = fundinglist[indexPath.row].order
        
        cell.title.text = product.productName
        cell.type.text = "리워드 / \(product.productType)"
        cell.userName.text = order.username
        var dayForamtter = ""
        for char in order.requestedAt {
            if char == "T" { break }
            dayForamtter.append(char)
        }
        cell.requestedAt.text = dayForamtter
        return cell
    }
}

extension FundingPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
