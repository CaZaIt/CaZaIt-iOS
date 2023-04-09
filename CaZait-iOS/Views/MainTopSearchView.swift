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
        textField.layer.cornerRadius = 100
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
        
        return textField
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        addSubview(searchTextfield)
        
        searchTextfield.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}
