//
//  DetailCafeByCafeIdModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation

struct DetailCafeByCafeIdResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: DetailCafeByCafeIdData
}

struct DetailCafeByCafeIdData: Codable {
    let cafeId: Int
    let congestionStatus: String
    let name: String
    let address: String
    let longitude: String
    let latitude: String
    let cafeImages: [String]
}
