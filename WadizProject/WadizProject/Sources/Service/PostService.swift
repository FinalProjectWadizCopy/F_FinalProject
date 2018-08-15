//
//  PostService.swift
//  WadizProject
//
//  Created by Jo JANGHUI on 2018. 8. 12..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation
import Alamofire

struct API {
    static let rewardsURL = "https://www.ryanden.kr/api/rewards"
    static var nextURL = ""
}

struct PostService {
    func rewardPostList(completion: @escaping (Rewards) -> ()) {
        Alamofire.request(API.rewardsURL)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let rewardList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(rewardList)
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
    
    func nextRewardPostList(completion: @escaping (Rewards) -> ()) {
        Alamofire.request(API.nextURL)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let rewardList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(rewardList)
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}

