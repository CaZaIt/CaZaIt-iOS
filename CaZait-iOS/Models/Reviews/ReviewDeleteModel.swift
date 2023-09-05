//
//  ReviewDeleteModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/09/05.
//

import Foundation

struct ReviewDeleteResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: ReviewDeleteData
}

struct ReviewDeleteData: Codable {
    let reviewId: String
}
