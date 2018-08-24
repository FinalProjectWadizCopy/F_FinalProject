//
//  LodingView.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 16..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class LodingView: UIView {
    
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let size = CGSize(width: 50, height: 50)
        activityIndicator.frame = CGRect(x: frame.midX - (size.width / 2),
                                         y: frame.midY - (size.height / 2),
                                         width: size.width,
                                         height: size.height)
        
        addSubview(activityIndicator)
        
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator.layer.cornerRadius = size.height / 2
        activityIndicator.color = UIColor.black
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.startAnimating()
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
