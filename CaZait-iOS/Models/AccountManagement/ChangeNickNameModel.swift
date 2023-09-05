//
//  ChangeNickNameModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/25.
//

import Foundation

struct ChangeNickNameResponse: Codable {
    let code: Int
    let result, message: String
    let data: UserNickNameInfo
}

struct UserNickNameInfo: Codable {
    let id, accountName, phoneNumber, nickname: String
}
