//
//  Search.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 15..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation

struct Search: Decodable {
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
        guard let start = dateFormatter.date(from: self.startTime) else { return "err"}
        guard let end = dateFormatter.date(from: self.endTime) else { return "err" }
        
        let interval = end.timeIntervalSince(start)
        let day = Int(interval / 86400)
        return String(day) + "일 남음"
    }
    
    var isFinish: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        guard let start = dateFormatter.date(from: self.startTime) else { return true }
        guard let end = dateFormatter.date(from: self.endTime) else { return true }
        
        let interval = end.timeIntervalSince(start)
        let day = Int(interval / 86400)
        guard day > 20 else { return false }
        return true
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
        print(self.totalAAmount)
        print(self.currentAmount)
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
