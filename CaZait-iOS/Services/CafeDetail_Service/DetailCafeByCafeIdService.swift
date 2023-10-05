//
//  DetailCafeService.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation
import Alamofire

class DetailCafeByCafeIdService{
    func getDetailCafeBycafeID(cafeID: String, completion: @escaping (Result<DetailCafeByCafeIdData, Error>) -> Void) {
        let url = APIConstants.detailCafeURL + "/\(cafeID)"
        
        print(url)

        AF.request(url)
            .validate()
            .responseDecodable(of: DetailCafeByCafeIdResponse.self) { response in
                switch response.result {
                case .success(let cafeResponse):
                    if cafeResponse.result == "SUCCESS" {
                        completion(.success(cafeResponse.data))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: cafeResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getDetailCafeBycafeIDToken(cafeID: String, userID: String, completion: @escaping (Result<DetailCafeByCafeIdData, Error>) -> Void) {
        let url = APIConstants.detailCafeURL + "/\(cafeID)" + "/users/\(userID)"
        
        print(url)
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: DetailCafeByCafeIdResponse.self) { response in
                switch response.result {
                case .success(let cafeResponse):
                    if cafeResponse.result == "SUCCESS" {
                        completion(.success(cafeResponse.data))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: cafeResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
