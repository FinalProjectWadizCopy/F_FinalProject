//
//  SignViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

class SignViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    
    
    
    @IBOutlet private weak var emailSignupButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.center = self.view.center
        fbLoginButton.frame = CGRect(x: 10, y: 350, width: 355, height: 45)
        fbLoginButton.readPermissions = ["public_profile", "email"]
        fbLoginButton.delegate = self
        
        self.view.addSubview(fbLoginButton)
        
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.numberOfLines = 2

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
