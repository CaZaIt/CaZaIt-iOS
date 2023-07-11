//
//  CafeDetailViewMenuCell.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/18.
//

import UIKit

class CafeDetailViewMenuCell: UICollectionViewCell {
    
    private let menuImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        if let coffeeImage = UIImage(named: "coffee1") {
            image.image = coffeeImage
        }
        
        //image.layer.borderWidth = 1.0
        //image.layer.masksToBounds = false
        //image.layer.borderColor = UIColor(red: 253/255, green: 172/255, blue: 159/255, alpha: 1).cgColor
        image.layer.cornerRadius = 5
        image.clipsToBounds = true // cornerRadius 설정 후, corner 부분이 제대로 출력되게 하기 위해서 사용합니다.

        
        return image
    }()

    
    private let menu: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "아메리카노"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "3500원"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let menuDescription: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "우리나라 원두를 사용하여 \n더욱 달달한 풍미가 살아있는 아메리카노"
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
        // 서브뷰들을 추가합니다.
        addSubview(menuImage)
        addSubview(menu)
        addSubview(price)
        addSubview(menuDescription)
    }
    
    private func setupLayout() {
        // 서브뷰들의 레이아웃을 설정합니다.
        menuImage.translatesAutoresizingMaskIntoConstraints = false
        menu.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        menuDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            menuImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            //menuImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            menuImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            menuImage.widthAnchor.constraint(equalToConstant: 80),
            menuImage.heightAnchor.constraint(equalToConstant: 80),

            menu.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 25),
            menu.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            price.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 150),
            price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),

            menuDescription.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 25),
            menuDescription.topAnchor.constraint(equalTo: menu.bottomAnchor, constant: 8),
            //menuDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(menuImage: UIImage?, menu: String, price: String, menuDescription: String) {
        // 셀의 내용을 설정합니다.
        self.menuImage.image = menuImage
        self.menu.text = menu
        self.price.text = price
        self.menuDescription.text = description
    }
}
