//  CafeDetailViewReviewCell.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/18.
//

import UIKit

class CafeDetailViewReviewCell: UICollectionViewCell {
    
    var stars: [UIImageView] = []

    private let star: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        if let coffeeImage = UIImage(named: "coffee1") {
            image.image = coffeeImage
        }
        
        return image
    }()

    
    private let nickname: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "화양동뚜벅초"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let hour: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "3시간전"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let review: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "카페분위기가 좋아요"
        label.numberOfLines = 0 // 자동으로 줄 수 결정

        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // 셀의 설정을 수행합니다.
        backgroundColor = .white
        contentView.clipsToBounds = true
        
         // 그림자 효과를 위한 설정
        layer.shadowColor = UIColor(red: 1, green: 0.774, blue: 0.735, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 9
        self.layer.cornerRadius = 10

    }
    
    private func addSubviews() {
        contentView.addSubview(nickname)
        contentView.addSubview(hour)
        contentView.addSubview(review)
    }
    
    private func setupLayout() {
        // 서브뷰들의 레이아웃을 설정합니다.
        nickname.translatesAutoresizingMaskIntoConstraints = false
        hour.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            nickname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nickname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),

            hour.leadingAnchor.constraint(equalTo: nickname.trailingAnchor, constant: 20),
            hour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            review.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            review.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 6),
            //review.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
  
        ])
    }

    
    func configure(nickname: String, hour: String, review: String) {
        // 셀의 내용을 설정합니다.
        self.nickname.text = nickname
        self.hour.text = hour
        self.review.text = review
    }
}
