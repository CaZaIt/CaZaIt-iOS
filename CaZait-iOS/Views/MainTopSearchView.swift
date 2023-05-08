//
//  MainTopSearchView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/06.
//

import UIKit
import SnapKit

class MainTopSearchView: UIView {
    
    private let searchTextfield: InsetTextField = {
        
        let textField = InsetTextField()
        
        textField.placeholder = "search" //text가 비어있을 때 표시되는 글
        textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.cornerRadius = 20 //둥글게 만들어 줍니다.
        textField.textColor = UIColor(r: 255, g: 255, b: 255)
        textField.setPlaceholder(color: UIColor(r: 255, g: 255, b: 255))
        textField.insetX = 47 //왼쪽에 사진을 추가하기 위해 마진을 추가합니다.
        textField.addleftimage(image: UIImage(named: "search"))
        textField.font = UIFont(name: "AppleSDGothicNeoM00-Regular", size: 16)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 4
        textField.layer.shadowOpacity = 0.25
        textField.keyboardType = .default // 한글 기본 키보드
        
        return textField
    }()
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(named: "mini_logo")
        imageView.bounds.size = CGSize(width: 28, height: 39)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 18.5
        button.clipsToBounds = true //해당 뷰의 bounds 밖으로 넘치는 콘텐츠를 잘라내서 보여줄지 여부를 결정
        button.setImage(UIImage(named:"menu"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        addSubview(searchTextfield)
        addSubview(logoImageView)
        addSubview(menuButton)
        
        searchTextfield.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(46)
            make.width.equalTo(256)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(28)
            make.centerY.equalToSuperview()
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-23)
            make.centerY.equalToSuperview()
            make.height.equalTo(37)
            make.width.equalTo(37)
        }
    }

}
