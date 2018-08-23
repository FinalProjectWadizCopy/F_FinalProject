//
//  EntryViewController.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

final class EntryViewController: UIViewController {
    
    static func create() -> Self {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let `self` = storyboard.instantiateViewController(ofType: self.self)
        return `self`
    }
}
