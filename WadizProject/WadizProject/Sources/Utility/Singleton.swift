//
//  Singleton.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 18..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation
import UIKit

final class GrideView {
    static let shared = GrideView()
    var isShow = true
}

final class Color {
    static let shared = Color()
    
    var symbolColor = UIColor(red: 0.451, green: 0.796, blue: 0.639, alpha: 1)
}
