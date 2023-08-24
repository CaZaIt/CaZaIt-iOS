//
//  ChangePasswordModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/24.
//

import Foundation

struct ChangePasswordResponse: Codable {
    let code: Int
    let result, message: String
    let data: UserInfo
}

struct UserPasswordInfo: Codable {
    let id, accountName, password, phoneNumber, nickname: String
}
