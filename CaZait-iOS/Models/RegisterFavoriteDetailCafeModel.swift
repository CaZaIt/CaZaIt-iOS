//
//  RegisterFavoriteDetailCafeModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/23.
//

import Foundation

struct RegisterFavoriteDetailCafeResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: RegisterFavoriteDetailCafeData
}

struct RegisterFavoriteDetailCafeData: Codable {
    let id: Int
}
