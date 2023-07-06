//
//  MoreView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import UIKit

class MoreView: UIViewController{
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.87, blue: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "더보기"
        label.numberOfLines = 1
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        view.addSubview(whiteView)
        whiteView.addSubview(pinkView)
        whiteView.addSubview(moreLabel)
        
        
        self.whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.whiteView.snp.top)
            make.height.equalTo(100)
        }
        
        self.moreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(30)
        }
    }
}

