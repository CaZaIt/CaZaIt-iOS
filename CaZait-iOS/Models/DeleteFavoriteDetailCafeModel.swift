//
//  DeleteFavoriteDetailCafeModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/23.
//

import Foundation

struct DeleteFavoriteDetailResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: DeleteFavoriteDetailData
}

struct DeleteFavoriteDetailData: Codable {
    let id: Int
}
