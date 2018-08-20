//
//  CategoryTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

protocol CategorybuttonDelegate: class {
    func presentView(_ title: String)
}

class CategoryTableViewCell: UITableViewCell {
    weak var delegate: CategorybuttonDelegate?
    
    let categoryTitle = ["전체보기", "테크·가전", "패션·잡화", "뷰티", "푸드", "홈리빙", "디자인소품", "여행·레저", "스포츠·모빌리티", "반려동물", "공연·컬처", "소셜·캠페인", "교육·키즈", "게임·취미", "출판"]

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: "CategoryCell")
    }
    
    @objc func actionCategoryButton (_ button: UIButton) {
        guard let title = button.titleLabel?.text else { return }
        delegate?.presentView(title)
    }
    
}

// MARK: - UICollectionViewDataSource

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CategoryCell",
            for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryCellButton.setBackgroundImage(
            UIImage(named: categoryTitle[indexPath.row]),
            for: .normal)
        cell.categoryCellTitle.text = categoryTitle[indexPath.row]
        cell.categoryCellButton.titleLabel?.text = categoryTitle[indexPath.row]
        cell.categoryCellButton.addTarget(self, action: #selector(actionCategoryButton(_:)), for: .touchUpInside)
        
        if indexPath.row == 0 {
            cell.categoryCellButton.layer.borderWidth = 2
            cell.categoryCellButton.layer.borderColor = Color.shared.symbolColor.cgColor
            cell.categoryCellTitle.textColor = Color.shared.symbolColor
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private struct Metric {
        static let numberOfLine: CGFloat = 3.3
        
        static let leftPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 10.0
        static let topPadding: CGFloat = 0.0

        static let bottomPadding: CGFloat = 0
        
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10
        
        static let nextOffset: CGFloat = 10.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        let horizontalPadding = Metric.leftPadding + Metric.lineSpacing + Metric.nextOffset
        let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
        let height = width - Metric.topPadding - Metric.bottomPadding
        return CGSize(width: width, height: height)}
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return Metric.lineSpacing
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
        return Metric.itemSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Metric.topPadding, Metric.leftPadding,
                                Metric.bottomPadding, Metric.rightPadding)
    }
}
