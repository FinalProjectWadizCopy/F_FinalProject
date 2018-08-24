//
//  like.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 24..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation


struct Like: Decodable {
    let productInterestedCount: String
    
    enum CodingKeys: String, CodingKey {
        case productInterestedCount = "product_interested_count"
    }
}
