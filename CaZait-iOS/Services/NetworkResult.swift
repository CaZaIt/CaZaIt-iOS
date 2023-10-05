//
//  NetworkResult.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T) //서버 통신 성공
    case requestErr(T) //요청 에러가 발생
    case pathErr // 경로 에러
    case serverErr //서버 내부 에러
    case networkFail //네트워크 연결 실패
    case tokenErr
}
