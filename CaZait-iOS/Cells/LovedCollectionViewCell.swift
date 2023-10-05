//
//  CollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/05.
//

import UIKit
import SnapKit

class LovedCollectionViewCell: UICollectionViewCell {
    
    private let congestionMapping: [String: String] = [
        "NONE": "미등록",
        "CLOSE": "종료",
        "FREE": "여유",
        "NORMAL": "보통",
        "CROWDED": "혼잡",
        "VERY_CROWDED": "매우혼잡"
    ]
    
    private let cafeNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = .black
        label.textAlignment = .left
        label.text = "롬곡"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let cafeLocationLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 13)
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin) //위에 폰트가 적용되지 않아 임시로 추가
        label.textColor = .black
        label.textAlignment = .left
        label.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        label.numberOfLines = 3
        
        return label
    }()
    
    private let congestionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let congestionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "보통"
        label.numberOfLines = 1
        
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 1, green: 0.531, blue: 0.531, alpha: 0.25).cgColor // 그림자 색깔
        self.layer.shadowOpacity = 1 // 그림자 투명도
        self.layer.shadowRadius = 14 // 그림자 크기
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.cornerRadius = 10
        
        setupContentView()
    }
    
    func setupContentView() {
        contentView.addSubview(cafeNameLabel)
        
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.leading.equalTo(contentView.snp.leading).offset(17)
        }
        
        contentView.addSubview(cafeLocationLabel)
        
        cafeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(cafeNameLabel.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        contentView.addSubview(congestionView)
        
        congestionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(127)
            make.leading.equalTo(contentView.snp.leading).offset(17)
            make.width.equalTo(98)
            make.height.equalTo(33)
        }
        
        congestionView.addSubview(congestionLabel)
        
        congestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(congestionView.snp.centerX)
            make.centerY.equalTo(congestionView.snp.centerY)
        }
    }
    
    //전달받은 통신 데이터를 통해 적용해줍니다.
    func configure(with favoritesInfo: FavoritesInfo) {
        cafeNameLabel.text = favoritesInfo.name
        cafeLocationLabel.text = favoritesInfo.address
        congestionLabel.text = congestionMapping[favoritesInfo.congestion]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

