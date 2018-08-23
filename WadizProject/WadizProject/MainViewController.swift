//
//  MainViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//
import UIKit


final class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    static func create() -> UINavigationController {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let `self` = storyboard.instantiateViewController(ofType: self.self)
        let navigation = UINavigationController(rootViewController: `self`)
        return navigation
    }
}
