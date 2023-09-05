//
//  NewPasswordModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/30.
//

import Foundation

struct NewPasswordResponse: Codable {
    let code: Int
    let result, message: String
    let data: NewPasswordInfo
}

struct NewPasswordInfo: Codable {
    let id, accountName, password, phoneNumber, nickname: String
}
