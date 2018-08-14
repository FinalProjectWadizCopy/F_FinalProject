//
//  Rewards.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 12..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation

struct Rewards: Decodable {
    let count: Int
    let next: String
    let results: [Results]
    
    struct Results: Decodable{
        let pk: Int
        let productName: String
        let type: String
        let companyName: String
        let productImg: String
        let interestedCount: Int
        let startTime: String
        let endTime: String
        let currentAmount: Int
        let totalAAmount: Int
        
        
        enum CodingKeys: String, CodingKey {
            case pk
            case productName = "product_name"
            case type = "product_type"
            case companyName = "product_company_name"
            case productImg = "product_img"
            case interestedCount = "product_interested_count"
            case startTime = "product_start_time"
            case endTime = "product_end_time"
            case currentAmount = "product_cur_amount"
            case totalAAmount = "product_total_amount"
            
        }
    }
}
