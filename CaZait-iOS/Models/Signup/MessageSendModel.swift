//
//  MessageSendModel.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/08/04.
//

import Foundation

// MARK: - MessageSendResponse
struct MessageSendResponse: Codable {
    let data: MessageSendData?
    let message: String
    let result: String
    let code: Int
}

// MARK: - MessageSendData
struct MessageSendData: Codable {
    let recipientPhoneNumber: String
    let requestTime: String
    let verificationCode: Int
}
