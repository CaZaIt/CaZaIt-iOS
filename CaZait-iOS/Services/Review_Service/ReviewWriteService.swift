//
//  ReviewWriteService.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/20.
//

import Foundation
import Alamofire

class ReviewWriteService {
    func postReview(userId: String, cafeId: Int, review: Review, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/reviews/user/\(userId)/cafe/\(cafeId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJpYXQiOjE2OTAzMDM3NDAsImV4cCI6MTY5MDMwNTU0MCwidXNlcklkeCI6IjE3NDMzYjk4LTRmMzItNDBmNS1hMmMzLWMxMzY1YjMzYmNlNCJ9.a_IbYlrVk_mx2RcpzRgYtcjgvWe0TJ_jkdCOEBpuZL8" // 여기에 발급받은 JWT 토큰을 넣어주세요.
        ]
        
        let parameters: [String: Any] = [
            "score": review.score,
            "content": review.content
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
