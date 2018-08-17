//
//  EmptyView.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 16..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    let textLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let textLabelSize = CGSize(width: frame.width, height: 30)
        textLable.frame = CGRect(x: frame.origin.x,
                                 y: frame.midY + textLabelSize.height,
                                 width: textLabelSize.width,
                                 height: textLabelSize.height)
        textLable.text = "선택한 카테고리는 프로젝트가 없습니다."
        textLable.textColor = UIColor.black
        textLable.font = UIFont.init(name: "Helvetica Neue", size: 15)
        textLable.textAlignment = .center
        addSubview(textLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
