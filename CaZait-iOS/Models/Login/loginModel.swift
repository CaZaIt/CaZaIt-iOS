//
//  loginModel.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/24.
//

import Foundation


struct LoginResponse: Codable {
    let data: LoginData?
    let message: String
    let result: String
}

struct LoginData: Codable {
    let accountName: String
    let id: String
    let accessToken: String
    let refreshToken: String
    let role: String
}
