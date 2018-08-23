//
//  MenuView.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    let layerView = UIView()
    let margin = CGFloat(10)
    let fundingList = UIButton()
    let likeListButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.frame.origin = CGPoint(x: frame.origin.x - frame.width, y: frame.origin.y)
        backgroundColor = UIColor.white
//        setSignUpView()
        setSignIpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSignUpView(){
        let signInButton = UIButton()
        let detailLabel = UILabel()
        let signUPButton = UIButton()
        
        addSubview(signInButton)
        addSubview(detailLabel)
        addSubview(signUPButton)
        
        signInButton.setTitle("로그인", for: .normal)
        signInButton.setTitleColor(UIColor.black, for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signInButton.contentHorizontalAlignment = .leading
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabel.text = "더 놀라운 와디즈를 만나보세요."
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        detailLabel.textColor = UIColor.black
        detailLabel.textAlignment = .left
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signUPButton.setTitle("회원가입", for: .normal)
        signUPButton.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
        signUPButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signUPButton.contentHorizontalAlignment = .leading
        signUPButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let guide = safeAreaLayoutGuide
        
        signInButton.topAnchor.constraint(equalTo: guide.topAnchor,
                                          constant: margin * 3).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: margin).isActive = true
        
        detailLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor).isActive = true
        
        signUPButton.centerYAnchor.constraint(equalTo: detailLabel.centerYAnchor).isActive = true
        signUPButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -(margin)).isActive = true
        
        addLayerView(signUPButton)
        addMenu()
    }
    
    func setSignIpView(){
        let userImage = UIImageView()
        let userNameLabel = UILabel()
        
        
        let imageSize = CGFloat(55)
        
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(fundingList)
        addSubview(likeListButton)
        
        userImage.image = UIImage(named: "imagePicker")
        userImage.layer.cornerRadius = imageSize / 2
        userImage.layer.masksToBounds = true
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.text = "조장희"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userNameLabel.textColor = UIColor.black
        userNameLabel.textAlignment = .left
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fundingList.setTitle("펀딩 내역", for: .normal)
        fundingList.setTitleColor(UIColor.black, for: .normal)
        fundingList.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        fundingList.imageView?.image = UIImage(named: "fundingList")
        fundingList.contentHorizontalAlignment = .leading
        fundingList.translatesAutoresizingMaskIntoConstraints = false
        
        likeListButton.setTitle("좋아한 프로젝트", for: .normal)
        likeListButton.setTitleColor(UIColor.black, for: .normal)
        likeListButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        likeListButton.imageView?.image = UIImage(named: "fundingList")
        likeListButton.contentHorizontalAlignment = .leading
        likeListButton.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = safeAreaLayoutGuide

        userImage.topAnchor.constraint(equalTo: guide.topAnchor,
                                       constant: margin * 3).isActive = true
        userImage.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: margin).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        userImage.heightAnchor.constraint(equalTo: userImage.widthAnchor).isActive = true
        
        userNameLabel.topAnchor.constraint(equalTo: userImage.topAnchor,
                                           constant: margin / 2).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor,
                                               constant: margin * 2).isActive = true
        
        fundingList.topAnchor.constraint(equalTo: userImage.bottomAnchor,
                                           constant: margin * 5).isActive = true
        fundingList.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor,
                                               constant: 0).isActive = true
        
        likeListButton.centerYAnchor.constraint(equalTo: fundingList.centerYAnchor).isActive = true
        likeListButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -(margin * 2)).isActive = true
        
        
        addLayerView(fundingList)
        addMenu()
        
    }
    
    func addLayerView(_ button: UIButton) {
        
        addSubview(layerView)
        
        layerView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        layerView.translatesAutoresizingMaskIntoConstraints = false

        layerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        layerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        layerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        layerView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: margin).isActive = true
    }

    func addMenu() {
//        let homeButton = UIButton()
//        let rewordButton = UIButton()
        let subTextLabel = UILabel()

        subTextLabel.text = "와디즈 펀딩"
        subTextLabel.textColor = UIColor.black.withAlphaComponent(0.5)
        subTextLabel.font = UIFont.systemFont(ofSize: 13)
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        homeButton.setTitle("홈", for: .normal)
//        homeButton.setTitleColor(UIColor.black, for: .normal)
//        homeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        homeButton.contentHorizontalAlignment = .leading
//        homeButton.translatesAutoresizingMaskIntoConstraints = false
//
//        rewordButton.setTitle("리워드", for: .normal)
//        rewordButton.setTitleColor(UIColor.black, for: .normal)
//        rewordButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        rewordButton.contentHorizontalAlignment = .leading
//        rewordButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(subTextLabel)
//        addSubview(homeButton)
//        addSubview(rewordButton)
        
        subTextLabel.topAnchor.constraint(equalTo: layerView.bottomAnchor,
                                          constant: margin * 4).isActive = true
        subTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: margin).isActive = true

//        homeButton.topAnchor.constraint(equalTo: subTextLabel.bottomAnchor,
//                                        constant: margin).isActive = true
//        homeButton.leadingAnchor.constraint(equalTo: subTextLabel.leadingAnchor).isActive = true

//        rewordButton.topAnchor.constraint(equalTo: homeButton.bottomAnchor,
//                                          constant: margin).isActive = true
//        rewordButton.leadingAnchor.constraint(equalTo: subTextLabel.leadingAnchor).isActive = true
    }
}


