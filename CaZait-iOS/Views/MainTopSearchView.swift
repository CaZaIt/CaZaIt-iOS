//
//  MainTopSearchView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/06.
//

import UIKit
import SnapKit

class MainTopSearchView: UIView {
    
    let searchButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.25
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = "Search"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(12.6)
            make.centerY.equalToSuperview()
        }
        
        button.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(47)
            make.centerY.equalToSuperview()
        }
        
        return button
    }()
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(named: "mini_logo")
        imageView.bounds.size = CGSize(width: 28, height: 39)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton()
        
//        button.backgroundColor = .black
//        button.layer.cornerRadius = 18.5
        button.clipsToBounds = true //해당 뷰의 bounds 밖으로 넘치는 콘텐츠를 잘라내서 보여줄지 여부를 결정
        button.setImage(UIImage(named:"notifications"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    private let notificationDotView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 3
        
        return view
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
        addSubview(searchButton)
        addSubview(logoImageView)
        addSubview(notificationButton)
        addSubview(notificationDotView)
        
        searchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(46)
            make.width.equalTo(256)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(28)
            make.centerY.equalToSuperview()
        }
        
        notificationButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-23)
            make.centerY.equalToSuperview()
            make.height.equalTo(37)
            make.width.equalTo(37)
        }
        
        notificationDotView.snp.makeConstraints { make in
            make.top.equalTo(notificationButton.snp.top).offset(3)
            make.trailing.equalTo(notificationButton.snp.trailing).offset(-1)
            make.height.equalTo(6)
            make.width.equalTo(6)
        }
    }

    func hiddenNotificationDot() {
        notificationDotView.isHidden = true
    }
    
    func appearNotificationDot() {
        notificationDotView.isHidden = false
    }
}
