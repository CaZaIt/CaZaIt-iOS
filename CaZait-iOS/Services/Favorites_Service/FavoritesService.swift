//
//  FavoritesService.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/07/04.
//

import Foundation
import Alamofire
//(1) 라이브러리 추가

class FavoritesService {
    
    //싱글턴 패턴 - static 키워드를 통해 shared라는 프로퍼티에 싱글턴 인스턴스 저장하여 생성
    //이를 통해서 여러 VC에서도 shared로 접근하면 같은 인스턴스에 접근할 수 있는 형태
    static let shared = FavoritesService()
    
    //completion클로저를 @escaping closure로 정의
    //->getAllShop 함수가 종료되든 말든 상관없이 completion은 탈출 클로저이기 때문에,
    //전달된다면 이후에 외부에서도 사용가능
    // **해당 completion클로저에는 네트워크의 결과를 담아서 호출하게 되고, VC에서 꺼내서 처리할 예정
    func getFavoritesCafeInfo(completion : @escaping (NetworkResult<Any>) -> Void) {
        
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let url = "\(APIConstants.favoritesURL)/\(userId)"
        
        var header : HTTPHeaders = ["Content-Type" : "application/json"]
        if let bearerToken = UserDefaults.standard.string(forKey: "accessToken") {
            header["Authorization"] = "Bearer \(bearerToken)"
        }
        //이렇게 통신 요청보낼거야! 라는 요청서라고 보면 된다.
        // URL 주소를 가지고, GET 방식을 통해, JSONEncoding 인코딩 방식으로
        // 헤더 정보와 함께 REquest를 보내기 위한 정보를 묶어서 dataRequest에 저장해둔다.
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        //위에서 적어둔 요청서를 가지고 진짜 서버에 보내서 통신 Request를 하는 중
        //통신이 완료되면 클로저를 통해서 dataResponse라는 이름으로 결과가 도착
        
        dataRequest.responseData{ dataResponse in
            
            //dataResponse가 도착했으니, 그 안에는 통신에 대한 결과물이 있다.
            //dataResponse.result에는 통신 성공했는지 실패했는지 여부가 들어있다.
            switch dataResponse.result {
                
                // dataResponse가 성공이면 statusCode와 response(결과데이터)를 저장한다.
            case .success:
                //dataResponse.statusCode는 Response의 statusCode - 200/400/500
                guard let statusCode = dataResponse.response?.statusCode else {return}
                // dataResponse.value는 Response의 결과 데이터
                guard let value = dataResponse.value else {return}
                
                //judgeStatus라는 함수에 statusCode와 response(결과 데이터)를 실어서 보낸다.
                let networkResult = self.judgeStatus(by: statusCode, value)
                
                switch networkResult {
                case .success:
                    completion(networkResult)
//                case .tokenErr:
//                    // 토큰 갱신 시도
//                    RefreshTokenService.shared.getRefreshToken { refreshTokenResult in
//                        switch refreshTokenResult {
//                        case .success:
//                            // 리프레시 성공 후 다시 즐겨찾기 정보 요청
//                            self.getFavoritesCafeInfo(completion: completion)
//                        default:
//                            // 리프레시 실패 등, 다른 오류 처리
//                            completion(refreshTokenResult)
//                        }
//                    }
                default:
                    completion(networkResult)
                }
                
                //통신 실패의 경우 completion에 pathErr값을 담아서 뷰컨으로 날려준다.
                // 타임아웃 / 통신 불가능의 상태로 통신 자체에 실패한 경우
            case .failure:
                completion(.pathErr)
            }
        }
    }
    
    // statusCode를 바탕으로 어떻게 결과값을 처리할 건지 정의한다.
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case ..<300 : return isVaildData(data: data) //성공 데이터를 가공해서 전달해야하기 때문에 isVaildData함수로 데이터 전송
        //case 401 : return .tokenErr
        case 400..<500 : return .pathErr //요청이 잘못됨
        case 500..<600 : return .serverErr //서버에러
        default : return .networkFail //네트워크 에러로 분기 처리할 예정
        }
    }
    
    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        
        //JSON 데이터를 해독하기 위해 JSONDecoder()를 하나 선언
        let decoder = JSONDecoder()
        
        // 실패하면 pathErr로 빼고, 성공하면 decodeData에 값을 뺀다.
        guard let decodedData = try? decoder.decode(FavoritesResponse.self, from: data) else { return .pathErr }
        
        // 성공적으로 decode를 마치면 success에다가 data 부분을 담아서 completion을 호출
        return .success(decodedData as Any)
    }
}
