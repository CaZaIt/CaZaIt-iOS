//
//  DeleteFavoriteDetailCafeService.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/23.
//

import Foundation
import Alamofire

class DeleteFavoriteDetailCafeService {
    func deleteFavoriteDetailCafe(userId: String, cafeId: Int, completion: @escaping (Result<DeleteFavoriteDetailResponse, Error>) -> Void) {
        let url = APIConstants.baseURL + "/api/favorites/delete/\(userId)/\(cafeId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJpYXQiOjE2OTAzMDM3NDAsImV4cCI6MTY5MDMwNTU0MCwidXNlcklkeCI6IjE3NDMzYjk4LTRmMzItNDBmNS1hMmMzLWMxMzY1YjMzYmNlNCJ9.a_IbYlrVk_mx2RcpzRgYtcjgvWe0TJ_jkdCOEBpuZL8" // 토큰값은 실제로 발급받은 토큰으로 대체해야 합니다.
        ]
        
        AF.request(url, method: .delete, headers: headers)
            .validate()
            .responseDecodable(of: DeleteFavoriteDetailResponse.self) { response in
                switch response.result {
                case .success(let deleteFavoriteDetailResponse):
                    completion(.success(deleteFavoriteDetailResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
