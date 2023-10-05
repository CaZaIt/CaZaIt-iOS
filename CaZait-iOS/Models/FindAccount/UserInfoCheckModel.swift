//
//  UserInfoCheckModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/26.
//

import Foundation

struct UserInfoCheckResponse: Codable {
    let code: Int
    let result, message: String
    let data: UserCheckInfo
}

struct UserCheckInfo: Codable {
    let accountName, phoneNumber: String
}
