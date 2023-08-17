//
//  signupModel.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/23.
//

import Foundation


// MARK: - SignupResponse
struct SignupResponse: Codable {
    let code: Int
    let data: SignupData?
    let message: String
    let result: String
}

// MARK: - SignupData
struct SignupData: Codable {
    let id: String
    let accountName: String
    let phoneNumber: String
    let nickname: String
}
