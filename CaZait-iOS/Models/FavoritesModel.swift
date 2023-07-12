//
//  FavoritesModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation

// MARK: - Hello
struct FavoritesResponse: Codable {
    let code: Int
    let result, message: String
    let data: [FavoritesInfo]
}

// MARK: - Datum
struct FavoritesInfo: Codable {
    let favoritesId, cafeId: Int
    let name, address, latitude, longitude: String
    let congestion: String
    let imageUrl: [String]
}
