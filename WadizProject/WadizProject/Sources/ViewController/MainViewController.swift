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
    @IBOutlet weak var leftNaviButton: UIBarButtonItem!
    
    var menuView: UIView!
    
    let pageController = UIPageControl()
    let symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
    
    var isMenuViewOn = false
    var MenuCGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView = MenuView(frame: view.frame)
        view.addSubview(menuView)
        
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

        view.addSubview(pageController)
        pageController.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.3)
        pageController.currentPageIndicatorTintColor = symbolColor
        
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.bottomAnchor.constraint(equalTo: recommendScrollView.bottomAnchor, constant: 0).isActive = true
        pageController.centerXAnchor.constraint(equalTo: recommendScrollView.centerXAnchor, constant: 0).isActive = true
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
    
    // MARK: - IBAction
    @IBAction func presentMenuView() {
        let moveLagnth = self.view.frame.width
        
        if !isMenuViewOn {
            MenuCGPoint = pageController.frame.origin
            pageController.frame.origin = view.frame.origin
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.menuView.frame.origin.x += moveLagnth
                strongSelf.leftNaviButton.image = UIImage(named: "exit")
                strongSelf.view.layoutIfNeeded()
                
            }
            isMenuViewOn = true
        } else {
            pageController.frame.origin = MenuCGPoint
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.menuView.frame.origin.x -= moveLagnth
                strongSelf.leftNaviButton.image = UIImage(named: "menu")
                strongSelf.view.layoutIfNeeded()
            }
            isMenuViewOn = false
        }
        
    }
}


// MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = page
    }
}






