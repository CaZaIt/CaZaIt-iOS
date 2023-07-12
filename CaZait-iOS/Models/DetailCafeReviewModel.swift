//
//  DetailCafeReviewModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/12.
//

import Foundation

struct DetailCafeReviewResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: DetailCafeReviewData
}

struct DetailCafeReviewData: Codable {
    let reviewResponses: [DetailCafeReview]
    let totalElements: Int
    let nextCursor: Int
}

struct DetailCafeReview: Codable {
    let userId: String
    let cafeId: Int
    let score: Int
    let content: String
}
