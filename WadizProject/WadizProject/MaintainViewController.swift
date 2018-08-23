//
//  MaintainViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    
    fileprivate func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "isLoggedIn")

    }
    
    
    static func create(with postService: PostServiceType = PostService()) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let `self` = storyboard.instantiateViewController(ofType: self.self)
        let navigation = UINavigationController(rootViewController: `self`)
        self.postService = postService
        return navigation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            switch result {
            case .success(let postList):
                
            case .error(let error):
                print(error)
            }
    }
}
