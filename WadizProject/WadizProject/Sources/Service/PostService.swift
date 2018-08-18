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
    static let rewardsURL = "https://ryanden.kr/api/rewards/search/?"
    static var nextURL = ""
    static let searchURL = "https://ryanden.kr/api/rewards/search/?product_name="
    static let categoryURL = "https://ryanden.kr/api/rewards/search/?category="
    
    static let detailURL = "https://ryanden.kr/api/rewards/"
}

struct PostService {
    func rewardGetList(completion: @escaping (Rewards) -> ()) {
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
    
    func nextRewardGetList(completion: @escaping (Rewards) -> ()) {
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
    
    func searchGetList(frame: CGRect, text: String,  completion: @escaping (Rewards) -> ()) {
        
        let lodingView = LodingView(frame: frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)
        
        print(text)
        let sumURL = API.searchURL + text
        print(sumURL)
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let searchList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(searchList)
                        lodingView.activityIndicator.stopAnimating()
                        lodingView.removeFromSuperview()
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
    
    
    func categoryGetList(frame: CGRect, title: String, completion: @escaping (Rewards) -> ()) {
        let lodingView = LodingView(frame: frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)
        
        let sumURL = API.categoryURL + title
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let searchList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(searchList)
                        lodingView.activityIndicator.stopAnimating()
                        lodingView.removeFromSuperview()
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
    
    func detailGetList(title: String, completion: @escaping (Detail) -> ()){
        let url = API.detailURL + title
        Alamofire.request(url)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let detailList = try JSONDecoder().decode(Detail.self, from: value)
                        completion(detailList)
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}

