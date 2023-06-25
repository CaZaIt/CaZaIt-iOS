//
//  AllCafeModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/23.
//

import Foundation

// MARK: - Welcome
struct AllCafeResponse: Codable {
    let code: Int
    let result, message: String
    let data: [[CafeInfo]]
}

// MARK: - Datum
struct CafeInfo: Codable {
    let cafeID: Int
    let congestionStatus, name, address: String
    let longitude, latitude: String
    let cafeImages: [String]
    let distance: Int
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case cafeID = "cafeId"
        case congestionStatus, name, address, longitude, latitude, cafeImages, distance, favorite
    }
}
