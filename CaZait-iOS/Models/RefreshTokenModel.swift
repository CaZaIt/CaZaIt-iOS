//
//  RefreshModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/07/20.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: TokenData
}

struct TokenData: Codable {
    let id: String
    let accountNumber: String
    let accessToken: String
    let refreshToken: String
    let role: String
}
