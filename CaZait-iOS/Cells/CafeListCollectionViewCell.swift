//
//  CafeListCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/06.
//

import UIKit
import SnapKit

class CafeListCollectionViewCell: UICollectionViewCell {
    
    private let cafeImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "small_cafe")
        
        return imageView
    }()
    
    private let cafeNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)//임시로 추가
        label.textColor = .black
        label.textAlignment = .left
        label.text = "팬도로시"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let cafeLocationDistanceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "220m"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let cafeLocationLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 13)
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
    
    private let congestionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "매우 혼잡"
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
        
        setupContentView()
    }
    
    func setupContentView() {
        
        contentView.addSubview(cafeImageView)
        
        cafeImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(22)
            make.width.equalToSuperview()
            make.height.equalTo(124)
        }
        
        contentView.addSubview(cafeNameLabel)
        
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeImageView.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(14)
        }
        
        contentView.addSubview(cafeLocationDistanceLabel)
        
        cafeLocationDistanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cafeNameLabel.snp.centerY)
            make.leading.equalTo(cafeNameLabel.snp.trailing).offset(34)
        }
        
        contentView.addSubview(cafeLocationLabel)
        
        cafeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(14)
            make.trailing.equalTo(contentView.snp.trailing).offset(12)
        }
        
        contentView.addSubview(congestionView)
        
        congestionView.snp.makeConstraints { make in
            make.top.equalTo(cafeLocationLabel.snp.bottom).offset(13)
            make.width.equalTo(140)
            make.height.equalTo(33)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        contentView.addSubview(congestionLabel)
        
        congestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(congestionView.snp.centerX)
            make.centerY.equalTo(congestionView.snp.centerY)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
