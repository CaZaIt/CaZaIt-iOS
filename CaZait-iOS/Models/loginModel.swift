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
    let email: String
    let id: Int
    let jwtToken: String
    let refreshToken: String
    let role: String
}