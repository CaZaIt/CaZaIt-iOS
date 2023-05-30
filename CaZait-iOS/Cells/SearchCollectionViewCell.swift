//
//  SearchCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/30.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let cafeImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "coffee1")
        
        return imageView
    }()
    
    private let cafeNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 19)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)//임시로 추가
        label.textColor = .black
        label.textAlignment = .left
        label.text = "팬도로시"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let cafeLocationLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 13)
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin) //위에 폰트가 적용되지 않아 임시로 추가
        label.textColor = .black
        label.textAlignment = .left
        label.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        label.numberOfLines = 2
        
        return label
    }()
    
    private let congestionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private let cafeCongestionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "보통"
        label.numberOfLines = 1
        
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor(red: 1, green: 0.875, blue: 0.851, alpha: 1).cgColor // 그림자 색깔
        self.layer.shadowOpacity = 1 // 그림자 투명도
        self.layer.shadowRadius = 9 // 그림자 크기
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.cornerRadius = 9
        
        setupContentView()
    }
    
    func setupContentView() {
        
        contentView.addSubview(cafeImageView)
        
        cafeImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(22)
            make.top.equalTo(contentView.snp.top).offset(22)
            make.bottom.equalTo(contentView.snp.bottom).offset(-22)
            make.height.width.equalTo(103)
        }
        
        contentView.addSubview(cafeNameLabel)
        
        cafeNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(cafeImageView.snp.trailing).offset(22)
            make.top.equalTo(contentView.snp.top).offset(22)
        }
        
        contentView.addSubview(cafeLocationLabel)
        
        cafeLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(cafeImageView.snp.trailing).offset(22)
            make.top.equalTo(contentView.snp.top).offset(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-60)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
        }
        
        contentView.addSubview(congestionView)
        
        congestionView.snp.makeConstraints { make in
            make.leading.equalTo(cafeImageView.snp.trailing).offset(22)
            make.top.equalTo(contentView.snp.top).offset(97)
            make.bottom.equalTo(contentView.snp.bottom).offset(-22)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
        }

        contentView.addSubview(cafeCongestionLabel)
        
        cafeCongestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(congestionView.snp.centerX)
            make.centerY.equalTo(congestionView.snp.centerY)
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
