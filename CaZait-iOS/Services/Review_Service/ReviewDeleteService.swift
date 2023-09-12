//
//  ReviewDeleteService.swift
//  CaZait-iOS
//
//  Created by J on 2023/09/05.
//

import Foundation
import Alamofire

class ReviewDeleteService {
    func deleteReview(reviewId: String, completion: @escaping (Result<ReviewDeleteResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/reviews/\(reviewId)"
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ReviewDeleteResponse.self) { response in
                switch response.result {
                case .success(let reviewDeleteResponse):
                    if reviewDeleteResponse.result == "SUCCESS" {
                        completion(.success(reviewDeleteResponse))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: reviewDeleteResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
