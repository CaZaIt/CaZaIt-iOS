//
//  ReviewEditService.swift
//  CaZait-iOS
//
//  Created by J on 2023/09/06.
//

import Foundation
import Alamofire

class ReviewEditService {
    func editReview(reviewId: String, review: Review, completion: @escaping (Result<ReviewEditResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/reviews/edit/\(reviewId)"
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }

        let parameters: [String: Any] = [
            "score": review.score,
            "content": review.content
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ReviewEditResponse.self) { response in
                switch response.result {
                case .success(let reviewEditResponse):
                    if reviewEditResponse.result == "SUCCESS" {
                        completion(.success(reviewEditResponse))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: reviewEditResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

