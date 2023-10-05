//
//  DeleteAccountModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/09/06.
//

import Foundation

struct DeleteAccountResponse: Codable {
    let code: Int
    let result, message: String
    let data: DeleteInfo
}

struct DeleteInfo: Codable {
    let id, accountName, phoneNumber, nickname: String
    
}
