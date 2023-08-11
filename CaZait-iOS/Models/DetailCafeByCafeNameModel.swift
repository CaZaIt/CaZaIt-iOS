//
//  DetailCafeByCafeNameModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/08/11.
//

import Foundation

struct DetailCafeByCafeNameResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: [[DetailCafeByCafeNameData]]
}

struct DetailCafeByCafeNameData: Codable {
    let cafeId: Int
    let congestionStatus: String
    let name: String
    let address: String
    let longitude: String
    let latitude: String
    let cafeImages: [String]
    let distance: Int
    let favorite: Bool
}
