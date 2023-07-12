//
//  DetailCafeReviewService.swift
//  CaZait-iOS
//
//  Created by J on 2023/07/12.
//

import Foundation
import Alamofire

class DetailCafeReviewService{
    func getDetailCafeReviewBycafeID(cafeID: Int, completion: @escaping (Result<DetailCafeReviewData, Error>) -> Void) {
        let url = APIConstants.cafeReviewURL + "/\(cafeID)" + "/all"
        
        print(url)

        AF.request(url)
            .validate()
            .responseDecodable(of: DetailCafeReviewResponse.self) { response in
                switch response.result {
                case .success(let DetailCafeReviewResponse):
                    if DetailCafeReviewResponse.result == "SUCCESS" {
                        completion(.success(DetailCafeReviewResponse.data))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: DetailCafeReviewResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
