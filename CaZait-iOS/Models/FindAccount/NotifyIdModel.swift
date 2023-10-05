//
//  NotifyIdModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/30.
//

import Foundation

struct NotifyIdResponse: Codable {
    let code: Int
    let result, message: String
    let data: UserIdInfo
}

struct UserIdInfo: Codable {
    let accountName: String
}
