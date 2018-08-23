//
//  loginSegue.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class loginSegue: UIStoryboardSegue {

    override func perform() {
        let startVC = self.source
        
        let destinationVC = self.destination
        
        UIView.transition(from: startVC, to: destinationVC, duration: 2, options: .transitionCurlDown)
        
        
    }
    
}
