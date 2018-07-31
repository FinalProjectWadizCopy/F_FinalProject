//
//  MainViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var recommendScrollView: UIScrollView!
    let pageController = UIPageControl()
    let symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRecommendScrollView()
    }
    
    func setNavigation() {
        let titleView = UILabel()
        titleView.textColor = symbolColor
        titleView.text = "Wadiz"
        titleView.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleView
    }
    
    func setRecommendScrollView () {
        recommendScrollView.isPagingEnabled = true
        recommendScrollView.showsHorizontalScrollIndicator = false
        recommendScrollView.delegate = self
        
        guard let ad1 = UIImage(named: "ad1"),
            let ad2 = UIImage(named: "ad2"),
            let ad3 = UIImage(named: "ad3"),
            let ad4 = UIImage(named: "ad4")
            else { return }
        
        let recommendArray = [ad1, ad2, ad3, ad4]
        recommendArray.forEach(addPageScrollView(with:))
        
        let pageSize = CGSize(width: 40, height: 20)
        
        pageController.frame = CGRect(
            origin: CGPoint(x: recommendScrollView.frame.midX - (pageSize.width / 2),
                            y: recommendScrollView.frame.maxY - (pageSize.height)),
            size: pageSize
        )
        
        pageController.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
        pageController.currentPageIndicatorTintColor = symbolColor
        view.addSubview(pageController)
    }
    
    func addPageScrollView(with image: UIImage) {
        let pageFrame = CGRect(
            origin: CGPoint(x: recommendScrollView.contentSize.width, y: 0),
            size: recommendScrollView.frame.size
        )
        let addImage = UIImageView(image: image)
        addImage.frame = pageFrame
        recommendScrollView.addSubview(addImage)
        recommendScrollView.contentSize.width += view.frame.width
        pageController.numberOfPages += 1
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = page
    }
}
