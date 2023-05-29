//
//  SearchCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/30.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 1, green: 0.875, blue: 0.851, alpha: 1).cgColor // 그림자 색깔
        self.layer.shadowOpacity = 1 // 그림자 투명도
        self.layer.shadowRadius = 11 // 그림자 크기
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.cornerRadius = 10
        
        setupContentView()
    }
    
    func setupContentView() {
        
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
