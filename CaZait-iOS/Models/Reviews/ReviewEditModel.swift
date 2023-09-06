//
//  ReviewEditModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/09/06.
//

import Foundation

struct ReviewEditResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: ReviewEditeData
}

struct ReviewEditeData: Codable {
    let reviewId: String
    let score: Int
    let content: String
    let updateAt: String
}
