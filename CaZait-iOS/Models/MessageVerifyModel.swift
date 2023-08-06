//
//  MessageVerifyModel.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/08/06.
//

import Foundation

// MARK: - MessageSendResponse
struct MessageVerifyResponse: Codable {
    let data: MessageVerifyData?
    let message: String
    let result: String
    let code: Int
}

// MARK: - MessageSendData
struct MessageVerifyData: Codable {
    let recipientPhoneNumber: String
}
