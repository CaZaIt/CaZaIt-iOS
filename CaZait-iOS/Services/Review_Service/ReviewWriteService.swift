//
//  ReviewWriteService.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/20.
//

import Foundation
import Alamofire

class ReviewWriteService {
    func postReview(userId: String, cafeId: String, review: Review, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/reviews/user/\(userId)/cafe/\(cafeId)"
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }

        let parameters: [String: Any] = [
            "score": review.score,
            "content": review.content
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ReviewResponse.self) { response in
                switch response.result {
                case .success(let reviewResponse):
                    if reviewResponse.result == "SUCCESS" {
                        completion(.success(reviewResponse))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: reviewResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
