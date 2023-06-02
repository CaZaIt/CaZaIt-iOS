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
    let congestionStatus, name, address, longitude: String
    let latitude: String
    let getCafeImageRes: [CafeImage]
    let distance: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case cafeID = "cafeId"
        case congestionStatus, name, address, longitude, latitude, getCafeImageRes, distance, favorite
    }
}

// MARK: - GetCafeImageRe
struct CafeImage: Codable {
    let cafeImageID: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case cafeImageID = "cafeImageId"
        case imageURL = "imageUrl"
    }
}
