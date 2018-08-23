//
//  UserInfo.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    let pk: Int
    let username: String
    let nickname: String
    let likeProducts: [LikeProducts]
    let fundingSet: [FundingSet]
    enum CodingKeys: String, CodingKey {
        case pk, username, nickname
        case fundingSet = "funding_set"
        case likeProducts = "like_products"
    }
    
    struct LikeProducts: Decodable {
        let pk: Int
        let user: Int
        let product: Int
        let productName: String
        let productType: String
        let productCompanyName: String
        let productImg: String
        let productInterestedCount: String
        let productStartTime: String
        let productEndTime: String
        let productCurAmount: String
        let productTotalAmount: String
        let productIsFunding: String
        let likedAt: String
        
        var remainingDay: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY.MM.dd"
            let nowDate = Date()
            guard let end = dateFormatter.date(from: self.productEndTime) else { return "err" }
            
            let interval = end.timeIntervalSince(nowDate)
            let day = Int(interval / 86400)
            
            return String(day) + "일 남음"
        }
        
        var totalAmountFormatter: String {
            let intTotal = Int(self.productTotalAmount)
            let decimalFormatter = NumberFormatter()
            decimalFormatter.numberStyle = NumberFormatter.Style.decimal
            decimalFormatter.groupingSeparator = ","
            decimalFormatter.groupingSize = 3
            guard let result = decimalFormatter.string(from: intTotal! as NSNumber) else { return "0" }
            return result + "원"
        }
        
        var totalPercent: String {
            let total = Double(self.productTotalAmount)
            let current = Double(self.productCurAmount)
            let percent = Int((current! / total!) * 100)
            return String(percent) + "%"
        }
        
        var progress: Float {
            let total = Double(self.productTotalAmount)
            let current = Double(self.productCurAmount)
            let percent = (current! / total!)
            return Float(percent)
        }
        
        enum CodingKeys: String, CodingKey {
            case pk, user, product
            case productName = "product_name"
            case productType = "product_type"
            case productCompanyName = "product_company_name"
            case productImg = "product_img"
            case productInterestedCount = "product_interested_count"
            case productStartTime = "product_start_time"
            case productEndTime = "product_end_time"
            case productCurAmount = "product_cur_amount"
            case productTotalAmount = "product_total_amount"
            case productIsFunding = "product_is_funding"
            case likedAt = "liked_at"
        }
    }
    
    
    struct FundingSet: Decodable {
        let pk: Int
        let order: Order
        let rewardAmount: Int
        let reward: Reward
        
        enum CodingKeys: String, CodingKey {
            case pk, order, reward
            case rewardAmount = "reward_amount"
        }
        
        
        struct Order: Decodable {
            let username: String
            let phoneNumber: String
            let address1: String
            let address2: String
            let comment: String
            let requestedAt: String
            
            enum CodingKeys: String, CodingKey {
                case username, address1, address2, comment
                case phoneNumber = "phone_number"
                case requestedAt = "requested_at"
            }
        }
        
        
        struct Reward: Decodable {
            let product: Product
            
            struct Product: Decodable {
                let productName: String
                let productType: String
                let productCompanyName: String
                let productIsFunding: String
                
                enum CodingKeys: String, CodingKey {
                    case productName = "product_name"
                    case productType = "product_type"
                    case productCompanyName = "product_company_name"
                    case productIsFunding = "product_is_funding"
                }
            }
        }
    }
}
