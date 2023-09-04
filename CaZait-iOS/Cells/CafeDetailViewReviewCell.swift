//  CafeDetailViewReviewCell.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/18.
//

import UIKit

class CafeDetailViewReviewCell: UICollectionViewCell {
    
    var score = 1
    
    // 꽉찬 별
    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill",
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    }()

    // 빈별
    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star",
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    }()
    
    let emergencyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "light.beacon.max",
                                                   withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .medium))?.withTintColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), renderingMode: .alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let nickname: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "화양동뚜벅초"
        label.numberOfLines = 1
        
        return label
    }()
    
    
    private let declaration: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        label.textAlignment = .left
        label.text = "신고"
        label.numberOfLines = 1
        
        return label
    }()

    
    
    private let review: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakStrategy = .hangulWordPriority
        
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
        contentView.addSubview(review)
        contentView.addSubview(declaration)
    }
    
    private func setupLayout() {
        nickname.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false
        
        
        nickname.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(55)
            make.leading.equalTo(contentView.snp.leading).offset(25)
        }
        
        
        declaration.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(23)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
        }

        
        review.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
        }
    }
    
    func displayStars(starCount: Int) {
        let containerView = UIView()
        contentView.addSubview(containerView)
        var previousStarImageView: UIImageView?

        for index in 1...5 {
            let starImageView = UIImageView(image: index <= starCount ? starFillImage : starEmptyImage)
            containerView.addSubview(starImageView)
            
            starImageView.snp.makeConstraints { make in
                // 별 이미지 뷰가 이전 별 이미지 뷰 뒤에 오도록 설정
                if let previousStar = previousStarImageView {
                    make.leading.equalTo(previousStar.snp.trailing).offset(2)
                } else {
                    make.leading.equalTo(containerView.snp.leading)
                }
                make.top.equalTo(containerView.snp.top)
                make.width.height.equalTo(24) // 별 이미지 뷰 크기 설정
                
                previousStarImageView = starImageView // 이전 별 이미지 뷰를 업데이트
            }
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(23)
        }

    }

    
    func configure(nickname: String, review: String, score: Int) {
        // 셀의 내용을 설정합니다.
        self.nickname.text = nickname
        self.review.text = review
        self.score = score
        displayStars(starCount: score)

    }
}
