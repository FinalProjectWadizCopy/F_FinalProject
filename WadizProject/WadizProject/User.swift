//
//  User.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 23..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import Foundation

struct User: Decodable {
    let pk: Int
    let username: String
    var name: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case user
        case token
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case pk
        case username
        case name = "name"
        case email
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let token = try values.decodeIfPresent(String.self, forKey: .token)
        
        let userDict: KeyedDecodingContainer<User.AdditionalInfoKeys>
        if token != nil {
            UserManager.token = token
            userDict = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .user)
        } else {
            userDict = try decoder.container(keyedBy: AdditionalInfoKeys.self)
        }
        
        pk = try userDict.decode(Int.self, forKey: .pk)
        username = try userDict.decode(String.self, forKey: .username)
        name = try userDict.decodeIfPresent(String.self, forKey: .name)
        email = try userDict.decodeIfPresent(String.self, forKey: .email)
    }
}
