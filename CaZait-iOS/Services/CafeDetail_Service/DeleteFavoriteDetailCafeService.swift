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
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }
        
        
        AF.request(url, method: .delete, headers: header)
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
