//
//  Home.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class Home: UIViewController {
    
    @IBAction func logOutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "ISLoggedOut")
        self.navigationController?.popToRootViewController(animated: true)
    }
}
