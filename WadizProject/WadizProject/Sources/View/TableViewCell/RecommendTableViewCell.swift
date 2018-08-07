//
//  RecommendTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendScrollView: UIScrollView!
    
    let buttonTitle = ["ad1", "ad2", "ad3", "ad4"]
    
    var buttonArr: [UIButton] = []
    var contentButton: UIButton!
    
    let pageController = UIPageControl()
    let symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
    
    static var viewFrame: CGRect!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRecommendScrollView()
    }
    
    func setRecommendScrollView () {
        recommendScrollView.isPagingEnabled = true
        buttonTitle.forEach(addPageScrollView(with:))
        
        addSubview(pageController)
        pageController.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
        pageController.currentPageIndicatorTintColor = symbolColor
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.bottomAnchor.constraint(equalTo: recommendScrollView.bottomAnchor,
                                               constant: 0).isActive = true
        pageController.centerXAnchor.constraint(equalTo: recommendScrollView.centerXAnchor,
                                                constant: 0).isActive = true
    }
    
    func addPageScrollView(with title: String) {
        let pageFrame = CGRect(
            origin: CGPoint(x: recommendScrollView.contentSize.width, y: recommendScrollView.frame.minY),
            size: recommendScrollView.frame.size
        )
        
        contentButton = UIButton()
        contentButton.frame = pageFrame
        contentButton.setBackgroundImage(UIImage(named: title), for: .normal)
        contentButton.titleLabel?.text = title
        buttonArr.append(contentButton)

        recommendScrollView.addSubview(contentButton)
        recommendScrollView.contentSize.width += RecommendTableViewCell.viewFrame.width
        pageController.numberOfPages += 1
    }

}

// MARK: - UIScrollViewDelegate

extension RecommendTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = page
    }
}
