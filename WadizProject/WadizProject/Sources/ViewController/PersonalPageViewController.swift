//
//  Feature_PersonalPage_ViewController.swift
//  WadizCopyProject
//
//  Created by In Tak Han on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class PersonalPageViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let rewards = PostService()
    var likeList: [UserInfo.LikeProducts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: "CardCell", bundle: nil),
            forCellWithReuseIdentifier:"CardCell"
        )
        
        if !likeList.isEmpty {
            collectionView.isHidden = false
        }else {
            collectionView.isHidden = true
            let size = CGSize(width: view.frame.width / 1.7, height: 200)
            let textLable = UILabel()
            textLable.frame = CGRect(origin: CGPoint(x: view.frame.midX - (size.width / 2),
                                                     y: view.frame.midX),
                                     size: size)
            
            textLable.text = "좋아하는 프로젝트가 없습니다. 프로젝트를 좋아해 보실래요?"
            textLable.numberOfLines = 3
            view.addSubview(textLable)
        }
    }
    
}
extension PersonalPageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return likeList.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell",
                                                      for: indexPath) as! CardCell
        let like = likeList[indexPath.row]
        cell.rewardProgress.progress = like.progress

        cell.persentLabel.text = like.totalPercent
        cell.rewardLabel.text = like.totalAmountFormatter
        cell.dayLabel.text = like.remainingDay
        cell.prodectLabel.text = like.productName
        cell.brandLabel.text = like.productCompanyName
        
        let url = URL(string: like.productImg)
        cell.mainImage.kf.setImage(with: url)
        cell.proLable.text = like.productType
        
        return cell
    }
}

extension PersonalPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailView = storyboard.instantiateViewController(
            withIdentifier: "DetailView") as! DetailViewController
        let pk = likeList[indexPath.row].product
        rewards.detailGetList(pk: pk) { (detail) in
            detailView.detailData = detail
            self.navigationController?.pushViewController(detailView, animated: true)
        }
        return true
    }
}
