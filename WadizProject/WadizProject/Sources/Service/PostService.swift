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
    static let sortingURL = "https://ryanden.kr/api/rewards/search/?ordering="
    static let detailURL = "https://ryanden.kr/api/rewards/"
    static let userInfoURL = "https://ryanden.kr/api/users/myinfo/"
    static let likeURL = "https://ryanden.kr/api/rewards/product_like/"
    
    static let param = ["Authorization" : "Token 66ad49fb44a660fa6043f0af9bd5a6f1769aa545"]
    static let userNumber = "17"
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
    
    func rewardsSearchGetList(frame: CGRect, text: String,  completion: @escaping (Rewards) -> ()) {
        let lodingView = LodingView(frame: frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)

        let sumURL = API.searchURL + text
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let rewardList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(rewardList)
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
                        let categoryhList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(categoryhList)
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
    
    func sortedGetList(frame: CGRect, title: String, category: String, completion: @escaping (Rewards) -> ()) {
        let lodingView = LodingView(frame: frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)
        var sumURL: String!
        
        if category == "" {
            sumURL = API.sortingURL + title
        } else {
            sumURL = API.sortingURL + title + "&category=" + category
        }
        
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let sorteList = try JSONDecoder().decode(Rewards.self, from: value)
                        completion(sorteList)
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
    
    func detailGetList(pk: Int, completion: @escaping (Detail) -> ()){
        let stringPk = String(pk)
        let url = API.detailURL + stringPk
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
    
    func fundingListGet(frame: CGRect, completion: @escaping (UserInfo) -> ()) {
        let lodingView = LodingView(frame: frame)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(lodingView)
        let sumURL = API.userInfoURL
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url, method: .get, headers: API.param)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let fundingList = try JSONDecoder().decode(UserInfo.self, from: value)
                        completion(fundingList)
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
    
    func changedLikeStatus(pk: Int, completion: @escaping (Like) -> ()) {
        let param: [String : Any] = ["user" : API.userNumber, "product" : pk]
        let sumURL = API.likeURL
        guard let url = sumURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Alamofire.request(url, method: .post, parameters: param , headers: API.param)
            .validate()
            .responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do {
                        let fundingList = try JSONDecoder().decode(Like.self, from: value)
                        completion(fundingList)
                    } catch {
                        print("post err")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
       })
    }
}

