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
        let url = APIConstants.baseURL + "/api/favorites/user/\(userId)/cafe/\(cafeId)"
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = UserDefaults.standard.string(forKey: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }
//        if let bearerToken = KeyChain.read(key: "accessToken") {
//                    header["Authorization"] = "Bearer \(bearerToken)"
//        }
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
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
