//
//  DetailViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 17..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var detailData: Detail!
    var checkOnTheButton = true
    var webUploadView: UIView!
    var checkgedheartImgView: UIImageView!
    var interestedCount = UILabel()
    var pundingView = UIView()
    var webView = WKWebView()
    let webViewPregross = UIProgressView()
    
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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addPundingButtonView()
        
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
        
        collectionView.backgroundColor = Color.shared.symbolColor.withAlphaComponent(0.3)
    }
    
    func setCollectionView() {
       let detailRewardCellNib =  UINib(nibName: "DetailRewardCollectionViewCell", bundle: nil)
        collectionView.register(detailRewardCellNib, forCellWithReuseIdentifier: "DetailReward")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    //MARK: - IBAction
    @IBAction func presentDetailWebView(_ sender: UIButton) {
        let topMargin = view.layoutMargins.top
        let bottomMargin = view.layoutMargins.bottom
        
        webUploadView = UIView()
        webUploadView.frame = view.frame
        webUploadView.frame.size.height -= bottomMargin
        webUploadView.frame.origin.y = view.frame.maxY
        webUploadView.backgroundColor = UIColor.white
        view.addSubview(webUploadView)
        
        let exitButton = UIButton()
        exitButton.frame = webUploadView.bounds
        exitButton.frame.size.height = 15
        exitButton.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        exitButton.addTarget(self, action: #selector(exitButton(_:)), for: .touchUpInside)
        webUploadView.addSubview(exitButton)
        
        let handleImgView = UIImageView()
        handleImgView.image = UIImage(named: "handle")
        let imageSize = CGSize(width: exitButton.frame.width / 6, height: exitButton.frame.height / 3)
        handleImgView.frame = CGRect(origin: CGPoint(x: exitButton.frame.midX - (imageSize.width / 2),
                                                     y: exitButton.frame.midY - (imageSize.height / 2)),
                                     size: imageSize)
        exitButton.addSubview(handleImgView)
        
        let secondExitButton = UIButton()
        secondExitButton.frame = CGRect(x: webUploadView.bounds.minX,
                                        y: exitButton.frame.maxY,
                                        width: 30,
                                        height: 30)
        secondExitButton.setImage(UIImage(named: "exit"), for: .normal)
        secondExitButton.addTarget(self, action: #selector(secondExitButton(_:)), for: .touchUpInside)
        webUploadView.addSubview(secondExitButton)
        
        let progressView = UIView()
        progressView.frame = secondExitButton.frame
        progressView.frame.origin.x = secondExitButton.frame.maxX
        progressView.frame.size.width = webUploadView.frame.width - secondExitButton.frame.width
        progressView.backgroundColor = UIColor.clear
        webUploadView.addSubview(progressView)
        
        webViewPregross.frame = secondExitButton.frame
        webViewPregross.frame.size.width = webUploadView.frame.width - secondExitButton.frame.width
        webViewPregross.transform = webViewPregross.transform.scaledBy(x: 1, y: 15)
        webViewPregross.progressTintColor = UIColor.gray.withAlphaComponent(0.2)
        webViewPregross.trackTintColor = UIColor.white
        progressView.addSubview(webViewPregross)
        
        let addressBarLabel = UILabel()
        addressBarLabel.frame = webViewPregross.frame
        addressBarLabel.frame.origin.x += 10
        addressBarLabel.frame.size.width = webUploadView.frame.width - secondExitButton.frame.width
        addressBarLabel.backgroundColor = UIColor.clear
        addressBarLabel.text = "https://www.google.com/"
        addressBarLabel.font = UIFont.systemFont(ofSize: 12)
        addressBarLabel.textColor = UIColor.black
        progressView.addSubview(addressBarLabel)
        
        
        let myURL = URL(string: "https://www.google.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let webViewMargin = webUploadView.bounds.height - secondExitButton.frame.height - exitButton.frame.height - topMargin
        webView.frame = CGRect(x: webUploadView.bounds.minX,
                               y: secondExitButton.frame.maxY,
                               width: webUploadView.bounds.width,
                               height: webViewMargin)
        webUploadView.addSubview(webView)


        UIView.animate(withDuration: 0.5) { [weak self] () in
            guard let strongSelf = self else { return }
            strongSelf.webUploadView.frame.origin.y = topMargin
            strongSelf.loadViewIfNeeded()
        }
        view.bringSubview(toFront: pundingView)
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
           webViewPregross.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func exitButton (_ button: UIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] () in
            guard let strongSelf = self else { return }
            strongSelf.webUploadView.frame.origin.y = strongSelf.view.frame.maxY
            strongSelf.loadViewIfNeeded()
        }
    }
    
    @objc func secondExitButton (_ button: UIButton) {
        webUploadView.removeFromSuperview()
    }
    
    func addPundingButtonView () {
        let bottomMargin = view.layoutMargins.bottom
        let margin = CGFloat(5)
        pundingView.frame.size =
            CGSize(width: view.bounds.width,
                   height: 50)
        pundingView.frame.origin =
            CGPoint(x: view.frame.minX,
                    y: view.frame.maxY - pundingView.frame.size.height - bottomMargin)
        pundingView.backgroundColor = Color.shared.symbolColor
        view.bringSubview(toFront: pundingView)
        view.addSubview(pundingView)

        let likeButton = UIButton()
        let likeButtonSize = CGSize(width: pundingView.frame.height * 2 - (margin * 4),
                                    height: pundingView.frame.height - (margin * 4))
        likeButton.frame = CGRect(origin: CGPoint(x: pundingView.bounds.minX + (margin * 2),
                                                  y: pundingView.bounds.minY + (margin * 2)),
                                  size: likeButtonSize)
        likeButton.backgroundColor = UIColor.clear
        likeButton.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        likeButton.layer.borderWidth = 1
        likeButton.addTarget(self, action: #selector(cheangeLikeStatus), for: .touchUpInside)
        pundingView.addSubview(likeButton)
        
        checkgedheartImgView = UIImageView()
        checkgedheartImgView.image = UIImage(named: "emptyLike")
        checkgedheartImgView.frame = CGRect(origin: CGPoint(x: likeButton.bounds.minX + margin ,
                                                            y: likeButton.bounds.minY + margin),
                                            size: CGSize(width: likeButton.frame.height - (margin * 2),
                                                         height: likeButton.frame.height - (margin * 2)))
        likeButton.addSubview(checkgedheartImgView)
        interestedCount.font = UIFont(name: "Helvetica Neue", size: 15)
        let interestedCountSize = CGSize(width: (checkgedheartImgView.frame.height * 2), height: checkgedheartImgView.frame.height)
        interestedCount.frame = CGRect(origin: CGPoint(x: likeButton.bounds.maxX - interestedCountSize.width - margin,
                                                  y: likeButton.bounds.midY - (interestedCountSize.height / 2)),
                                  size: interestedCountSize)
        likeButton.addSubview(interestedCount)

        let fundingButton = UIButton()
        fundingButton.frame = CGRect(x: likeButton.frame.maxX + margin,
                                     y: likeButton.frame.minY,
                                     width: pundingView.bounds.width - likeButton.frame.width - likeButton.frame.minX - (margin * 2),
                                     height: likeButton.frame.height)
        fundingButton.backgroundColor = UIColor.clear
        fundingButton.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        fundingButton.layer.borderWidth = 1
        fundingButton.setTitle("펀딩 하기", for: .normal)
        fundingButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15)
        fundingButton.setTitleColor(UIColor.white, for: .normal)
        fundingButton.addTarget(self, action: #selector(presentPundingView), for: .touchUpInside)
        pundingView.addSubview(fundingButton)
    }
    
    @objc func cheangeLikeStatus (_ button: UIButton) {
        let guideLabel = UILabel()
        guideLabel.frame = CGRect(origin: CGPoint(x: view.frame.minX, y: view.frame.maxY), size: CGSize(width: view.frame.width, height: 50))
        guideLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        guideLabel.textColor = UIColor.white
        guideLabel.font = UIFont.init(name: "Helvetica Neue", size: 15)
        guideLabel.textAlignment = .center
        view.addSubview(guideLabel)
        
        UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            guideLabel.frame.origin.y -= 70
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                guideLabel.frame.origin.y += 70
                self.view.layoutIfNeeded()
            }) { (true) in
                guideLabel.removeFromSuperview()
            }
        }
        
        if checkOnTheButton {
            checkgedheartImgView.image = UIImage(named: "Like")
            guideLabel.text = "저희 프로젝트를 좋아해 주셔서 감사합니다."
            checkOnTheButton = false
        } else {
            checkgedheartImgView.image = UIImage(named: "emptyLike")
            guideLabel.text = "좋아해 주셔서 감사합니다."
            checkOnTheButton = true
        }
    }
    
    @objc func presentPundingView() {
        print("present")
    }
}


extension DetailViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return detailData.rewards.count
    }
    

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailReward",
                                                      for: indexPath) as! DetailRewardCollectionViewCell
        let reward = detailData.rewards[indexPath.row]
        cell.price.text = "\(reward.rewardPrice)원"
        cell.name.text = reward.rewardName
        cell.options.text = reward.rewardOption
        cell.expectingDepartureDate.text = reward.rewardExpectingDepartureDate
        cell.totalCount.text = "제한수량 \(reward.rewardTotalCount)개"
        cell.shippingCharge.text = "\(reward.rewardShippingCharge)원"
        cell.soldCount.text = "총 \(reward.rewardSoldCount)개 펀딩 완료"
        cell.balanceCount.text = "현재 \(reward.rewardTotalCount - reward.rewardSoldCount)개 남음!"
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    private struct Metric {
        static let numberOfLine: CGFloat = 1
        
        static let lineSpacing: CGFloat = 20
        
        static let topPadding: CGFloat = 5
        static let bottomPadding: CGFloat = 5
        static let leftPadding: CGFloat = 10
        static let rightPadding: CGFloat = 10
        
        static let nextOffset: CGFloat = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
        print(lineSpacing)
        let horizontalPadding = Metric.leftPadding + Metric.rightPadding
        let width = collectionView.frame.width - lineSpacing - horizontalPadding
        let height = collectionView.frame.height - Metric.topPadding - Metric.bottomPadding
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Metric.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Metric.topPadding, Metric.leftPadding, Metric.bottomPadding, Metric.rightPadding)
    }
}
