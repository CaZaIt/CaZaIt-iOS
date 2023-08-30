//
//  UserPhoneCheckModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/30.
//

import Foundation

struct UserPhoneCheckResponse: Codable {
    let code: Int
    let result, message: String
    let data: String?
}
