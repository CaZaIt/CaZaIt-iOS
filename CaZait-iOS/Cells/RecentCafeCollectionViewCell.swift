//
//  RecentCafeCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/15.
//

import UIKit
import SnapKit
import Kingfisher

private let congestionMapping: [String: String] = [
    "NONE": "미등록",
    "CLOSE": "종료",
    "FREE": "여유",
    "NORMAL": "보통",
    "CROWDED": "혼잡",
    "VERYCROWDED": "매우혼잡"
]

class RecentCafeCollectionViewCell: UICollectionViewCell {
    
    
    private let cafeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "small_cafe2")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let cafeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "롬곡"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
//
//    private let DistanceLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "220m"
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = .black
//        return label
//    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "서울특별시 광진구 광나루로\n375-1 2층(군자동)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0 // 여러 줄로 표시 가능하도록 설정
        label.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈 설정
        return label
    }()
    
    private let congestionView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 20
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
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true // cornerRadius가 제대로 표시되도록 설정
        
        setupContentView()
    }
    
    func configure(with recentCafe: RecentModel) {
        cafeNameLabel.text = recentCafe.cafeName
        addressLabel.text = recentCafe.cafeLocation
        congestionLabel.text = congestionMapping[recentCafe.cafeCongestion]
        
        let url = URL(string: recentCafe.cafeImage)
        cafeImageView.kf.setImage(with: url)
    }
    
    func setupContentView() {        
        contentView.addSubview(cafeImageView)
        contentView.addSubview(cafeNameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(congestionView)
        contentView.addSubview(congestionLabel)
        
        
        cafeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(213)
            make.bottom.equalToSuperview().inset(20)
        }
        
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeImageView.snp.top).inset(10)
            make.leading.equalTo(cafeImageView.snp.trailing).offset(18)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(7)
            make.leading.equalTo(cafeImageView.snp.trailing).offset(18)
            make.trailing.equalTo(contentView.snp.trailing).inset(18)
        }
        
        congestionView.snp.makeConstraints { make in
            make.leading.equalTo(cafeImageView.snp.trailing).offset(18)
            make.height.equalTo(38)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
            make.trailing.equalTo(contentView.snp.trailing).inset(18)
        }
        
        congestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(congestionView.snp.centerX)
            make.centerY.equalTo(congestionView.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
