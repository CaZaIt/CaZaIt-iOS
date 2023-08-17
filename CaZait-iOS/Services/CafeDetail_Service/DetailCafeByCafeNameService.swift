//
//  DetailCafeByCafeNameService.swift
//  CaZait-iOS
//
//  Created by J on 2023/08/11.
//

import Foundation
import Alamofire

class DetailCafeByCafeNameService{
    func getDetailCafeBycafeName(cafeName: String, userId: String,longitude : String, latitude : String, sort : String, limit : String, completion: @escaping (Result<[[DetailCafeByCafeNameData]], Error>) -> Void) {
        
        let cafeNameEncoded = cafeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = "https://cazait.shop/api/cafes/name/\(cafeNameEncoded)/user/\(userId)?longitude=\(longitude)&latitude=\(latitude)&sort=\(sort)&limit=\(limit)"
        
        print(url)
        
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = KeyChain.read(key: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: DetailCafeByCafeNameResponse.self) { response in
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
