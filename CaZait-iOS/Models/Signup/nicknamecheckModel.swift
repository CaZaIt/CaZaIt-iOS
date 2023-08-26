//
//  nicknamecheckModel.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/23.
//

import Foundation


struct NicknameCheckResponse: Codable {
    let code: Int
    let data: String?
    let message: String
    let result: String
}

