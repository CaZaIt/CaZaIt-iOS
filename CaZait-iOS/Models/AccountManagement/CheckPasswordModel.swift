//
//  CheckPasswordModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/23.
//

import Foundation

struct CheckPasswordResponse: Codable {
    let code: Int
    let result, message: String
    let data: UserInfo
}

struct UserInfo: Codable {
    let id, accountName, phoneNumber, nickname: String
}
