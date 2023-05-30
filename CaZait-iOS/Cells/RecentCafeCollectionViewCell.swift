//
//  RecentCafeCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/15.
//

import Foundation
import UIKit
import SnapKit

class RecentCafeCollectionViewCell: UICollectionViewCell {
    
    
    private let CafeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "small_cafe2")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let CafeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "롬곡"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let DistanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "220m"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()

    private let AddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "서울특별시 광진구 광나루로\n375-1 2층(군자동)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0 // 여러 줄로 표시 가능하도록 설정
        label.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈 설정
        return label
    }()
    
    private let CongestionView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let CongestionLabel: UILabel = {
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
    
    func setupContentView() {        
        contentView.addSubview(CafeImageView)
        contentView.addSubview(CafeNameLabel)
        contentView.addSubview(DistanceLabel)
        contentView.addSubview(AddressLabel)
        contentView.addSubview(CongestionView)
        contentView.addSubview(CongestionLabel)
        
        
        CafeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(213)
            make.bottom.equalToSuperview().inset(20)
        }
        
        CafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeImageView.snp.top).inset(10)
            make.leading.equalTo(CafeImageView.snp.trailing).offset(18)
        }
        
        DistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeImageView.snp.top).inset(20)
            make.leading.equalTo(CafeNameLabel.snp.trailing).offset(10)
        }
        
        AddressLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeNameLabel.snp.bottom).offset(7)
            make.leading.equalTo(CafeImageView.snp.trailing).offset(18)
        }
        
        CongestionView.snp.makeConstraints { make in
            make.top.equalTo(AddressLabel.snp.bottom).offset(26)
            make.leading.equalTo(CafeImageView.snp.trailing).offset(18)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
            make.trailing.equalTo(contentView.snp.trailing).inset(18)
        }
        
        CongestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(CongestionView.snp.centerX)
            make.centerY.equalTo(CongestionView.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
