//
//  SearchCafeModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/30.
//

import Foundation


struct SearchCafeResponse: Codable {
    let code: Int
    let result, message: String
    let data: [[CafeInfos]]
}

struct CafeInfos: Codable {
    let cafeID: Int
    let congestionStatus, name, address, longitude: String
    let latitude: String
    let getCafeImageRes: [CafeImages]
    let distance: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case cafeID = "cafeId"
        case congestionStatus, name, address, longitude, latitude, getCafeImageRes, distance, favorite
    }
}

struct CafeImages: Codable {
    let cafeImageID: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case cafeImageID = "cafeImageId"
        case imageURL = "imageUrl"
    }
}
