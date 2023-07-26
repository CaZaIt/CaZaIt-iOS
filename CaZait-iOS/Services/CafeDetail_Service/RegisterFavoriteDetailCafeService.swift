//
//  DetailCafeFavoriteService.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/23.
//

import Foundation
import Alamofire

class RegisterFavoriteDetailCafeService {
    func postFavoriteDetailCafe(userId: String, cafeId: Int, completion: @escaping (Result<RegisterFavoriteDetailCafeResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/favorite/user/\(userId)/cafe/\(cafeId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJpYXQiOjE2OTAzMDM3NDAsImV4cCI6MTY5MDMwNTU0MCwidXNlcklkeCI6IjE3NDMzYjk4LTRmMzItNDBmNS1hMmMzLWMxMzY1YjMzYmNlNCJ9.a_IbYlrVk_mx2RcpzRgYtcjgvWe0TJ_jkdCOEBpuZL8" // 여기에 발급받은 JWT 토큰을 넣어주세요.
        ]

        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: RegisterFavoriteDetailCafeResponse.self) { response in
                switch response.result {
                case .success(let registerFavoriteDetailCafeResponse):
                    if registerFavoriteDetailCafeResponse.result == "SUCCESS" {
                        completion(.success(registerFavoriteDetailCafeResponse))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: registerFavoriteDetailCafeResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
