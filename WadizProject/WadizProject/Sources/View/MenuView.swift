//
//  MenuView.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.frame.origin = CGPoint(x: frame.origin.x - frame.width, y: frame.origin.y)
        backgroundColor = UIColor.white

        setSignUpView()
//        setSignIpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSignUpView(){
        let signUpView = UINib(nibName: "SignUpView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        signUpView.frame.size.width = frame.width
        signUpView.backgroundColor = UIColor.white
        addSubview(signUpView)
        addMenu(signUpView)
    }
    
    func setSignIpView(){
        let signIpView = UINib(nibName: "SignInView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        signIpView.frame.size.width = frame.width
        signIpView.backgroundColor = UIColor.white
        addSubview(signIpView)
        addMenu(signIpView)
    }

    func addMenu (_ view: UIView) {
        let homeButton = UIButton()
        let rewordButton = UIButton()
        let subTextLabel = UILabel()

        subTextLabel.text = "와디즈 펀딩"
        subTextLabel.textColor = UIColor.black.withAlphaComponent(0.5)
        subTextLabel.font = UIFont.systemFont(ofSize: 13)
        subTextLabel.translatesAutoresizingMaskIntoConstraints = false

        homeButton.setTitle("홈", for: .normal)
        homeButton.setTitleColor(UIColor.black, for: .normal)
        homeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        homeButton.contentHorizontalAlignment = .leading
        homeButton.translatesAutoresizingMaskIntoConstraints = false

        rewordButton.setTitle("리워드", for: .normal)
        rewordButton.setTitleColor(UIColor.black, for: .normal)
        rewordButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        rewordButton.contentHorizontalAlignment = .leading
        rewordButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(subTextLabel)
        view.addSubview(homeButton)
        view.addSubview(rewordButton)
        
        subTextLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 30).isActive = true
        subTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        homeButton.topAnchor.constraint(equalTo: subTextLabel.bottomAnchor).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: subTextLabel.leadingAnchor).isActive = true

        rewordButton.topAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 10).isActive = true
        rewordButton.leadingAnchor.constraint(equalTo: subTextLabel.leadingAnchor).isActive = true
    }

}


