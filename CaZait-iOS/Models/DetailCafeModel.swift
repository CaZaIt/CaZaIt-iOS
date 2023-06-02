//
//  DetailCafeModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation

struct DetailCafeResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: DetailCafe
}

struct DetailCafe: Codable {
    let cafeId: Int
    let congestionStatus: String
    let name: String
    let address: String
    let longitude: String
    let latitude: String
    let getCafeImageRes: [CafeImage]
    let logResult: String?
}

struct CafeImage: Codable {
    let cafeImageId: Int
    let imageUrl: String
}
