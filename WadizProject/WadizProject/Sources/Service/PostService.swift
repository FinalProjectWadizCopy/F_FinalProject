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
}

struct PostService {
    func rewardPostList() {
        Alamofire.request(API.rewardsURL)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let rewardList = try JSONDecoder().decode(Rewards.self, from: value)
                        print(rewardList.count)
                        for reward in rewardList.results {
                            print(reward.pk)
                            print(reward.name)
                            print(reward.type)
                            print(reward.companyName)
                            print(reward.interestedCount)
                            print(reward.startTime)
                            print(reward.endTime)
                            print(reward.currentAmount)
                            print(reward.totalAAmount)
                        }
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }

}
