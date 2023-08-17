//
//  ReviewWriteModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/20.
//

import Foundation

struct ReviewResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: ReviewData
}

struct ReviewData: Codable {
    let reviewId: Int
    let cafeId: Int
    let userId: String
    let score: Int
    let content: String
    let createdAt: String
}

struct Review: Codable {
    let score: Int
    let content: String
}
