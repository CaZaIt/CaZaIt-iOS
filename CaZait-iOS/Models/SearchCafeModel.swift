//
//  SearchCafeModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/06/23.
//

import Foundation

// MARK: - Welcome
struct SearchCafeResponse: Codable {
    let code: Int
    let result, message: String
    let data: [[SearchCafeInfo]]
}

// MARK: - Datum
struct SearchCafeInfo: Codable {
    let cafeID: Int
    let congestionStatus, name, address, longitude: String
    let latitude: String
    let cafeImages: [String]
    let distance: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case cafeID = "cafeId"
        case congestionStatus, name, address, longitude, latitude, cafeImages, distance, favorite
            }
}
