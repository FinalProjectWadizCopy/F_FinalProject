//
//  RewardsGridTableViewCell.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 13..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class RewardsGridTableViewCell: UITableViewCell {

    let productName = UILabel()         // 프로젝트 이름
    let productImg = UIImageView()      // 프로젝트 이미지
    let type = UILabel()                // 프로젝트 카테고리
    let companyName = UILabel()         // 프로젝트 회사 이름
    let dayFinish = UILabel()           // 프로젝트 마감 임박 표시 레이블
    let totalPercent = UILabel()        // 프로젝트 달성 %
    let currentAmount = UILabel()        // 프로젝트 목표 금액
    let dayLeft = UILabel()             // 프로젝트 남은 일
    let progress = UIProgressView()     // 프로젝트 목표금액
    
    var rowHeight: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productName.text = "커피맛이 진정한 기술이다. 5분만에 추출하는 콜드브루 커피머신"
        productImg.image = UIImage(named: "sampleImg")
        type.text = "테크·가전"
        companyName.text = "| 디메이커스"
        totalPercent.text = "2,000%"
        currentAmount.text = "20,000,000"
        dayLeft.text = "50일 남음"
        dayFinish.text = " 마감 임박 "
        
        addsubViews()
        addAutoGridLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addsubViews() {
        
        addSubview(productImg)
        addSubview(productName)
        addSubview(type)
        addSubview(companyName)
        addSubview(dayFinish)
        addSubview(currentAmount)
        addSubview(totalPercent)
        addSubview(dayLeft)
        addSubview(progress)
        
        productImg.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        companyName.translatesAutoresizingMaskIntoConstraints = false
        currentAmount.translatesAutoresizingMaskIntoConstraints = false
        totalPercent.translatesAutoresizingMaskIntoConstraints = false
        dayLeft.translatesAutoresizingMaskIntoConstraints = false
        dayFinish.translatesAutoresizingMaskIntoConstraints = false
        progress.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addAutoGridLayout() {
        rowHeight = 300
        addSubViewAttribute()
        
        productImg.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        productImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        productImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        productImg.heightAnchor.constraint(lessThanOrEqualTo: productImg.widthAnchor, multiplier: 0.5).isActive = true
        
        dayFinish.topAnchor.constraint(equalTo: productImg.topAnchor).isActive = true
        dayFinish.leadingAnchor.constraint(equalTo: productImg.leadingAnchor).isActive = true
        
        productName.topAnchor.constraint(equalTo: productImg.bottomAnchor, constant: 10).isActive = true
        productName.leadingAnchor.constraint(equalTo: productImg.leadingAnchor, constant: 5).isActive = true
        productName.trailingAnchor.constraint(equalTo: productImg.trailingAnchor, constant: -5).isActive = true
        
        
        type.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 5).isActive = true
        type.leadingAnchor.constraint(equalTo: productName.leadingAnchor).isActive = true
        
        companyName.centerYAnchor.constraint(equalTo: type.centerYAnchor).isActive = true
        companyName.leadingAnchor.constraint(equalTo: type.trailingAnchor, constant: 10).isActive = true
        
        progress.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 5).isActive = true
        progress.leadingAnchor.constraint(equalTo: productName.leadingAnchor).isActive = true
        progress.trailingAnchor.constraint(equalTo: productName.trailingAnchor).isActive = true
        
        totalPercent.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 5).isActive = true
        totalPercent.leadingAnchor.constraint(equalTo: progress.leadingAnchor).isActive = true
        
        currentAmount.bottomAnchor.constraint(equalTo: totalPercent.bottomAnchor).isActive = true
        currentAmount.leadingAnchor.constraint(equalTo: totalPercent.trailingAnchor, constant: 5).isActive = true
        
        dayLeft.bottomAnchor.constraint(equalTo: totalPercent.bottomAnchor).isActive = true
        dayLeft.trailingAnchor.constraint(equalTo: progress.trailingAnchor).isActive = true
    }
    
    func addSubViewAttribute() {
        let fontName = "Helvetica Neue"
        
        productName.font = UIFont.init(name: fontName, size: 20)
        productName.numberOfLines = 2
        
        type.font = UIFont.init(name: fontName, size: 15)
        companyName.font = type.font
        
        totalPercent.font = UIFont.init(name: fontName, size: 15)
        currentAmount.font = UIFont.init(name: fontName, size: 12)
        
        dayLeft.font = UIFont.init(name: fontName, size: 12)
        
        
        dayFinish.font = UIFont.init(name: fontName, size: 18)
        dayFinish.textColor = UIColor.white
        dayFinish.backgroundColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
        
        progress.trackTintColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
        
    }

}
