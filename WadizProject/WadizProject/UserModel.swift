//
//  UserModel.swift
//  WadizProject
//
//  Created by Pure Yun on 2018. 8. 22..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import Foundation

final class UserModel {
    //저장된 계정 정보
    var model: [User] = [
        User(email: "admin@admin.com", pw: "12345678"),
        User(email: "usinuniverse@gmail.com", pw: "12345678")
    ]
    
    struct User {
        var email: String
        var pw: String
    }
    
    //계정 정보 확인 함수
    func findUser(email: String, pw: String) -> Bool {
        for user in model {
            if user.email == email && user.pw == pw {
                return true
            }
        }
        return false
    }
    
    //회원 추가 함수
    func addUser(newID: String, newPassword: String) {
        let newUser = User(email: newID, pw: newPassword)
        model.append(newUser)
    }
}
