//
//  SearchTableViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/17.
//

import Foundation
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "search")
        
        return imageView
    }()
    
    private let searchExampleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoL00-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin) //위에 폰트가 적용되지 않아 임시로 추가
        label.textColor = .white
        label.textAlignment = .left
        label.text = "검색할 내용"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .black
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_insert")
        imageView.contentMode = .scaleAspectFit
        
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        return button
    }()
    
    //이동하려는 viewController가 navigationController 내에서 push될 수 있도록 navigationController를 추가
    weak var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .black
        setupTableViewCell()
        
    }
    
    func setupTableViewCell() {
        
        contentView.addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(36.15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.width.equalTo(15)
        }
        
        contentView.addSubview(searchExampleLabel)
        
        searchExampleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(70.2)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        contentView.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-35.8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.width.equalTo(15)
        }
        
    }
    
    
    func configure(with cafeInfo: CafeInfo) {
        searchExampleLabel.text = cafeInfo.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

