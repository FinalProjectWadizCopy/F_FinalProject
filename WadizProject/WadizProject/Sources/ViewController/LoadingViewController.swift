//
//  LoadingViewController.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 13..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let nextVCModelSegue = "appStart"
    private let symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
    
    private let firstRewards = PostService()
    private var rewardsArr: [Rewards.Results] = []
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:- @IBOulet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.color = symbolColor
        
        firstRewards.rewardPostList { (rewards) in
            self.rewardsArr = rewards.results
        }
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(viewPerformSegue),
                             userInfo: nil, repeats: true)
    }
    
    // MARK:- @objc
    @objc func viewPerformSegue() {
        performSegue(withIdentifier: nextVCModelSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let navi = segue.destination as? UINavigationController else { return }
        guard let secondVC = navi.topViewController as? MainViewController else { return }
        secondVC.rewardsArr = rewardsArr
    }
    
    deinit {
        print("deinit LoadingViewController")
    }
}
