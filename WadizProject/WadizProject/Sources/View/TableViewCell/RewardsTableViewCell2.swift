////
////  RewardsTableViewCell.swift
////  WadizProject
////
////  Created by Jo JANGHUI on 2018. 8. 6..
////  Copyright © 2018년 JhDAT. All rights reserved.
////
//
//import UIKit
//import Kingfisher
//
//class RewardsTableViewCell2: UITableViewCell {
//
//    @IBOutlet weak var rewardCollectionView: UICollectionView!
//    var categoryIndex: Int?
//    var cellHegiht: [CGFloat]?
//
//    let rewards = PostService()
//
//    var rewardsArr: [Rewards.Results]!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        rewardCollectionView.register(UINib(nibName: "RewardsCollectionViewCell", bundle: nil),
//                                      forCellWithReuseIdentifier: "RewardsCollectionCell")
//
//        rewardCollectionView.register(UINib(nibName: "RewardsGridCollectionViewCell", bundle: nil),
//                                      forCellWithReuseIdentifier: "RewardsGridCollectionViewCell")
//        rewardCollectionView.delegate = self
//        cellHegiht = [120, 350]
//    }
//
//    func rewardsList(_ cell: RewardsCollectionViewCell, _ indexPath: Int) {
//        self.rewards.rewardPostList { [weak self] (rewards) in
//            self?.rewardsArr = rewards.results
//            cell.titleButton.setTitle(self?.rewardsArr[indexPath].productName, for: .normal)
//            cell.categoryButton.setTitle(self?.rewardsArr[indexPath].type, for: .normal)
//            cell.brandTitleLabel.text = "|  " + (self?.rewardsArr[indexPath].companyName)!
//            guard let account = self?.rewardsArr[indexPath].totalAAmount else { return }
//            cell.currentAmountLabel.text = String(account)
//            guard let url = URL(string: (self?.rewardsArr[indexPath].productImg)!) else { return }
//            cell.imageButton.kf.setImage(with: url, for: UIControlState.normal)
//        }
//    }
//
//    func rewardsGridList(_ cell: RewardsGridCollectionViewCell, _ indexPath: Int) {
//        self.rewards.rewardPostList { [weak self] (rewards) in
//            self?.rewardsArr = rewards.results
//            cell.titleButton.setTitle(self?.rewardsArr[indexPath].productName, for: .normal)
//            cell.categoryButton.setTitle(self?.rewardsArr[indexPath].type, for: .normal)
//            cell.brandTitleLabel.text = "|  " + (self?.rewardsArr[indexPath].companyName)!
//            guard let account = self?.rewardsArr[indexPath].totalAAmount else { return }
//            cell.currentAmountLabel.text = String(account)
//            guard let url = URL(string: (self?.rewardsArr[indexPath].productImg)!) else { return }
//            cell.imageButton.kf.setImage(with: url, for: UIControlState.normal)
//        }
//    }
//
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension RewardsTableViewCell: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        return Int(Metric.numberOfLine)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if GrideView.shared.isShow {
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: "RewardsCollectionCell",
//                for: indexPath) as! RewardsCollectionViewCell
//            switch categoryIndex {
//            case nil:
//                rewardsList(cell, indexPath.row)
//            case 1:
//                cell.titleButton.setTitle("1111", for: .normal)
//                cell.imageButton.backgroundColor = UIColor.black
//            default:
//                return cell
//            }
//            return cell
//        }
//        else {
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: "RewardsGridCollectionViewCell",
//                for: indexPath) as! RewardsGridCollectionViewCell
//            switch categoryIndex {
//            case nil:
//                rewardsGridList(cell, indexPath.row)
//            case 1:
//                cell.titleButton.setTitle("1111", for: .normal)
//                cell.imageButton.backgroundColor = UIColor.black
//            default:
//                return cell
//            }
//            return cell
//        }
//    }
//
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension RewardsTableViewCell: UICollectionViewDelegateFlowLayout {
//    private struct Metric {
//        static let numberOfLine: CGFloat = 10
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//        ) -> CGSize {
//        let width = collectionView.frame.width
//        let height = collectionView.frame.height / (Metric.numberOfLine + 1)
//        return CGSize(width: width, height: height)
//    }
//}
