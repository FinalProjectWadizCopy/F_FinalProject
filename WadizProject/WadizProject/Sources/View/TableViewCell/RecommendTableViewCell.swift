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
    
    // 데이터 크롤링이 안되서 로컬 작업으로 하기로 함.
    let adTitle = ["다시는 보기 힘든 \n마감임박 펀딩모음",
                   "여행자의\n필수템이 돌아왔어요",
                   "허벅지가 굵어도,\n하체통통이여도\n괜찮아요",
                   "가장 진화한\n스케이트 보드",
                   "보리굴비 한 점에\n신세계가 펼쳐져요",
                   "어깨 위에\n사뿐",
                   "세상에서 가장 즐거운\n드라이 시간이 될꺼에요"]
    
    let subTitle = ["마지막 기회를 놓치지 마세요!",
                   "아침에 필요한 모든 기능을 땀은 킬리배낭이에요",
                   "장인이 만들어 완벽한 품질과 핏감을 자랑하는\n청바지에요",
                   "인공지능 시스템이 스탭을 제어해줘요",
                   "짭조름하고 쫀득한 맛이 일품인 보리굴비에요",
                   "매일의 나를 위한 가벼운 가죽가방이에요",
                   "드라이와 브러시가 하나로 합쳐진 그루밍 드라이기에요"]
    
    var buttonTitle = ["ad1", "ad2", "ad3", "ad4", "ad5", "ad6", "ad7"]
    
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
        
        for imgTitle in buttonTitle {
            addPageScrollView(with: imgTitle)
        }
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
            origin: CGPoint(x: recommendScrollView.contentSize.width,
                            y: recommendScrollView.frame.minY - 25),
            size: recommendScrollView.frame.size
        )
        
        contentButton = UIButton()
        contentButton.frame = pageFrame
        contentButton.setImage(UIImage(named: title), for: .normal)
        buttonArr.append(contentButton)
        
        recommendScrollView.addSubview(contentButton)
        recommendScrollView.contentSize.width += RecommendTableViewCell.viewFrame.width
        
        let titleText = UILabel()
        titleText.numberOfLines = 3
        titleText.font = UIFont.boldSystemFont(ofSize: 20)
        titleText.text = adTitle[pageController.numberOfPages]
        titleText.textColor = UIColor.white
        contentButton.addSubview(titleText)

        let subText = UILabel()
        subText.numberOfLines = 3
        subText.font = UIFont.boldSystemFont(ofSize: 10)
        subText.text = subTitle[pageController.numberOfPages]
        subText.textColor = UIColor.white
        contentButton.addSubview(subText)
        
        subText.translatesAutoresizingMaskIntoConstraints = false
        subText.leadingAnchor.constraint(equalTo: contentButton.leadingAnchor, constant: 10).isActive = true
        subText.bottomAnchor.constraint(equalTo: contentButton.bottomAnchor, constant: -20).isActive = true
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.leadingAnchor.constraint(equalTo: subText.leadingAnchor).isActive = true
        titleText.bottomAnchor.constraint(equalTo: subText.topAnchor, constant: -10).isActive = true
        
        
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
