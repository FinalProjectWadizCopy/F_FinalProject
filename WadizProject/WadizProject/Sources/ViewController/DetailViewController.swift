//
//  DetailViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 17..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailData: Detail!
    
    //MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dayLeft: UILabel!
    @IBOutlet weak var totalPrecent: UILabel!
    @IBOutlet weak var currentAmount: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
    }
    
    func setData() {
        titleLabel.text = detailData.productName
        dayLeft.text = detailData.remainingDay
        totalPrecent.text = detailData.totalPercent
        currentAmount.text = detailData.currentAmountFormatter
        progress.progress = detailData.progress
        let url = URL(string: detailData.productImg)
        mainImage.kf.setImage(with: url)
    }
    
    func setUI() {
        progress.trackTintColor = UIColor.gray
        progress.progressTintColor = Color.shared.symbolColor
        progress.backgroundColor = UIColor.gray
        progress.frame.size.height = CGFloat(10)
        
        scrollView.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height * 3))
        scrollView.contentSize.height = view.frame.height * 3
        
    }
}
