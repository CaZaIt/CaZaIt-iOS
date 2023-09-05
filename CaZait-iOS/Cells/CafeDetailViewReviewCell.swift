//  CafeDetailViewReviewCell.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/18.
//

import UIKit

protocol CafeDetailViewReviewCellDelegate: AnyObject {
    func deleteButtonTapped(in cell: CafeDetailViewReviewCell)
    func editButtonTapped(in cell: CafeDetailViewReviewCell)
}

class CafeDetailViewReviewCell: UICollectionViewCell {
    
    weak var delegate: CafeDetailViewReviewCellDelegate?

    var score = 1
    var myReview: Int = 0
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
    
    
    public let editnButton: UIButton = {
        let button = UIButton(type: .system)
        
        // 버튼의 타이틀과 스타일 설정
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), for: .normal)
        
        // 버튼의 동작 설정
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    public let barLabel: UILabel = {
        let label = UILabel()
        
        label.text = "|"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        
        return label
    }()
    
    public let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        
        // 버튼의 타이틀과 스타일 설정
        button.setTitle("신고", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), for: .normal)
        
        // 버튼의 동작 설정
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return button
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
        contentView.addSubview(deleteButton)
    }
    
    private func setupLayout() {
        nickname.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false
        
        
        nickname.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(55)
            make.leading.equalTo(contentView.snp.leading).offset(25)
        }
        
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(23)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
        }

        
        review.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
        }
    }
    
    private func setupEditButtonLayout() {
        editnButton.translatesAutoresizingMaskIntoConstraints = false
        barLabel.translatesAutoresizingMaskIntoConstraints = false

        editnButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(23)
            make.trailing.equalTo(contentView.snp.trailing).offset(-57)
        }

        barLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(28)
            make.trailing.equalTo(contentView.snp.trailing).offset(-54)
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

    @objc private func deleteButtonTapped() {
        delegate?.deleteButtonTapped(in: self)
    }
    
    @objc private func editButtonTapped() {
        delegate?.editButtonTapped(in: self)
    }
    
    func configure(userId: String, nickname: String, review: String, score: Int) {
        // 셀의 내용을 설정합니다.
        self.nickname.text = nickname
        self.review.text = review
        self.score = score
        displayStars(starCount: score)
        
        if userId == UserDefaults.standard.string(forKey: "userId") {
            contentView.addSubview(editnButton)
            contentView.addSubview(barLabel)
            
            setupEditButtonLayout()
            
            deleteButton.setTitle("삭제", for: .normal)
        } else {
            deleteButton.setTitle("신고", for: .normal)
        }
        
        let reviewHeight = self.review.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let numberOfLines = Int(reviewHeight / self.review.font.lineHeight)
        //print(myReview)
        
        //let cafeDetailView = CafeDetailView()
        //cafeDetailView.updateCellHeightForNumberOfLines(numberOfLines)

    }
}

