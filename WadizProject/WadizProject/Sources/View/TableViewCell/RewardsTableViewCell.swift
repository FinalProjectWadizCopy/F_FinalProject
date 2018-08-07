//
//  RewardsTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class RewardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rewardCollectionView: UICollectionView!
    var categoryIndex: Int?

    override func awakeFromNib() {
        super.awakeFromNib()

        rewardCollectionView.register(UINib(nibName: "RewardsCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: "RewardsCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - UICollectionViewDataSource

extension RewardsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Metric.numberOfLine)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardsCollectionCell", for: indexPath) as! RewardsCollectionViewCell
        switch categoryIndex {
        case 1:
            cell.titleButton.setTitle("1111", for: .normal)
            cell.imageButton.backgroundColor = UIColor.black
        default:
            return cell
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RewardsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private struct Metric {
        static let numberOfLine: CGFloat = 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height / (Metric.numberOfLine + 1)
        return CGSize(width: width, height: height)}
}
