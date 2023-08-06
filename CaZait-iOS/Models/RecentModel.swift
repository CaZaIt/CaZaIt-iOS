//
//  RecentModel.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/06.
//

import Foundation

struct RecentModel: Equatable {
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
