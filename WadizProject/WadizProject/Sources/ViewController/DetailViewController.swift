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
    var checkOnTheButton = true
    //MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPrecent: UILabel!
    @IBOutlet weak var currentAmount: UILabel!
    @IBOutlet weak var dayLeft: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var fundingPeriod: UILabel!
    @IBOutlet weak var interestedCount: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likebuttonOutlet: UIButton!
    
    //MARK: - IBAction
    @IBAction func likeButton(_ sender: UIButton) {
        let guideLabel = UILabel()
        guideLabel.frame = CGRect(origin: CGPoint(x: view.frame.minX, y: view.frame.maxY), size: CGSize(width: view.frame.width, height: 30))
        guideLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        guideLabel.textColor = UIColor.white
        guideLabel.font = UIFont.init(name: "Helvetica Neue", size: 12)
        guideLabel.textAlignment = .center
        view.addSubview(guideLabel)
        print(guideLabel.frame.origin.y)
        
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            guideLabel.frame.origin.y -= 40
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                guideLabel.frame.origin.y += 40
                self.view.layoutIfNeeded()
            }) { (true) in
                guideLabel.removeFromSuperview()
            }
        }

        if checkOnTheButton {
            likeImg.image = UIImage(named: "Like")
            guideLabel.text = "저희 프로젝트를 좋아해 주셔서 감사합니다."
            checkOnTheButton = false
        } else {
            likeImg.image = UIImage(named: "emptyLike")
            guideLabel.text = "좋아해 주셔서 감사합니다."
            checkOnTheButton = true
        }
    }
    @IBAction func presentPundingView(_ sender: UIButton) {
        print("presentPundingView")
    }
    
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
        totalAmount.text = String(detailData.totalAmountFormatter)
        interestedCount.text = String(detailData.interestedCount)
        fundingPeriod.text = detailData.startTime + "~" + detailData.endTime
    }
    
    func setUI() {
        progress.trackTintColor = UIColor.gray
        progress.progressTintColor = Color.shared.symbolColor
        progress.backgroundColor = UIColor.gray
        progress.frame.size.height = CGFloat(10)
        
        scrollView.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: view.frame.height * 3))
        scrollView.contentSize.height = view.frame.height * 3
        likebuttonOutlet.layer.borderWidth = 1
        likebuttonOutlet.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    }
}
