//
//  MainViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 7. 31..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    func setNavigation() {
        let titleView = UILabel()
        titleView.textColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
        titleView.text = "Wadiz"
        titleView.font = UIFont.boldSystemFont(ofSize: 20)
        navigationItem.titleView = titleView
    }
}
