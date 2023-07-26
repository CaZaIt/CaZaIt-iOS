//
//  DetailCafeFavoriteModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/23.
//

import Foundation


struct FavoriteDetailCafeResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: FavoriteDetailCafeData
}

struct FavoriteDetailCafeData: Codable {
    let id: Int
}
