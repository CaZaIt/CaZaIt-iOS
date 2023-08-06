//
//  RecentModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/06.
//

import Foundation
//동일한 모델이 있는지 확인하기 위해 Equatable를 사용하였고,
// 리스트를 UserDefaults에 저장하기 위해 Encodable 프로토콜을 사용하였다.
struct RecentModel: Equatable, Encodable {
    let cafeImage : String
    let cafeName : String
    let cafeLocation : String
    let cafeCongestion : String
    
    init(cafeImage: String, cafeName: String, cafeLocation: String, cafeCongestion: String) {
        self.cafeImage = cafeImage
        self.cafeName = cafeName
        self.cafeLocation = cafeLocation
        self.cafeCongestion = cafeCongestion
    }
}
