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
    let next: String?
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
        
        var totalAmountFormatter: String {
            let decimalFormatter = NumberFormatter()
            decimalFormatter.numberStyle = NumberFormatter.Style.decimal
            decimalFormatter.groupingSeparator = ","
            decimalFormatter.groupingSize = 3
            guard let result = decimalFormatter.string(from: self.totalAAmount as NSNumber) else { return "0" }
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
