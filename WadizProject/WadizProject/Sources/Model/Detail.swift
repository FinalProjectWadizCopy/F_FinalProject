//
//  Detail.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 17..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation

struct Detail: Decodable {
    let pk: Int
    let productName: String
    let type: String
    let companyName: String
    let productImg: String
    let productDetailImg: String
    let interestedCount: Int
    let startTime: String
    let endTime: String
    let currentAmount: Int
    let totalAAmount: Int
    let rewards: [DetailRewards]
    
    var remainingDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let nowDate = Date()
        guard let end = dateFormatter.date(from: self.endTime) else { return "err" }
        
        let interval = end.timeIntervalSince(nowDate)
        let day = Int(interval / 86400)
        
        return String(day) + "일 남음"
    }
    
    var isFinish: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let nowDate = Date()
        guard let end = dateFormatter.date(from: self.endTime) else { return "err" }
        
        let interval = end.timeIntervalSince(nowDate)
        let day = Int(interval / 86400)
        
        if day < 0 {
            return "마감"
        } else if day == 1 {
            return "오늘 마감"
        }else if day < 5 {
            return "마감 임박"
        } else {
            return "통과"
        }
    }
    
    var currentAmountFormatter: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        guard let result = decimalFormatter.string(from: self.currentAmount as NSNumber) else { return "0" }
        return result + "원"
    }
    
    var totalPercent: String {
        let total = Double(self.totalAAmount)
        let current = Double(self.currentAmount)
        
        let percent = Int((current / total) * 100)
        return String(percent) + "%"
    }
    
    var progress: Float {
        let total = Double(self.totalAAmount)
        let current = Double(self.currentAmount)
        
        let percent = (current / total)
        return Float(percent)
    }
    
    enum CodingKeys: String, CodingKey {
        case pk, rewards
        case productName = "product_name"
        case type = "product_type"
        case companyName = "product_company_name"
        case productImg = "product_img"
        case productDetailImg = "product_detail_img"
        case interestedCount = "product_interested_count"
        case startTime = "product_start_time"
        case endTime = "product_end_time"
        case currentAmount = "product_cur_amount"
        case totalAAmount = "product_total_amount"
    }
    
    struct DetailRewards: Decodable {        
        let pk: Int
        let rewardName: String
        let rewardOption: String
        let rewardPrice: Int
        let rewardShippingCharge: Int
        let rewardExpectingDepartureDate: String
        let rewardTotalCount: Int
        let rewardSoldCount: Int
        let rewardOnSale: Bool
        let product: Int
        
        enum CodingKeys: String, CodingKey {
            case pk, product
            case rewardName = "reward_name"
            case rewardOption = "reward_option"
            case rewardPrice = "reward_price"
            case rewardShippingCharge = "reward_shipping_charge"
            case rewardExpectingDepartureDate = "reward_expecting_departure_date"
            case rewardTotalCount = "reward_total_count"
            case rewardSoldCount = "reward_sold_count"
            case rewardOnSale = "reward_on_sale"
        }
        
    }
    
}
