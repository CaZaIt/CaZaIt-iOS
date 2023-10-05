//
//  NotificationCollectionViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/06/25.
//

import UIKit
import SnapKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    private let bellImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "bell")
        
        return imageView
    }()
    
    private let notificationTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)//임시로 추가
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.36, alpha: 1)
        label.textAlignment = .left
        label.text = "알림이 떴습니다!"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let notificationExpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)//임시로 추가
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.36, alpha: 1)
        label.textAlignment = .left
        label.text = "그런데 정확히 무슨 알림이 뜨는 건가요?"
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(red: 1, green: 0.45, blue: 0.36, alpha: 1).cgColor
        
        setupContentView()
    }
    
    func setupContentView() {
        
        contentView.addSubview(bellImageView)
        contentView.addSubview(notificationTitleLabel)
        contentView.addSubview(notificationExpLabel)
        
        bellImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(18)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(43)
            make.bottom.equalTo(contentView.snp.bottom).offset(-18)
        }
        
        notificationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.leading.equalTo(contentView.snp.leading).offset(93)
        }
        
        notificationExpLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(41)
            make.leading.equalTo(contentView.snp.leading).offset(93)
        }
    }
    //전달받은 통신 데이터를 통해 적용해줍니다.
    func configure(with cafeInfo: CafeInfo) {
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
