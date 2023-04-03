//
//  SwiftUIView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import UIKit
import SnapKit

class MyPageVC: UIViewController{
    
    private let topview: UIView = {
        let top = UIView()
        top.translatesAutoresizingMaskIntoConstraints = false
        top.backgroundColor = .black
        return top
    }()
    
    private let pinkview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.87, blue: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 45
        return view
    }()
    
    private let logoutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "로그아웃"
        label.numberOfLines = 1
        return label
    }()
    
    private let payview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.36, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.pinkview)
        self.view.addSubview(self.topview)
        self.view.addSubview(self.logoutLabel)
        self.view.addSubview(self.payview)
        
        self.pinkview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.height.equalTo(195)
        }
        
        self.topview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
            make.height.equalTo(66)
        }
        
        self.logoutLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).inset(39)
            make.top.equalTo(self.view.snp.top).inset(110)
        }

        self.payview.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.leading).inset(28)
            make.trailing.equalTo(self.view.snp.trailing).inset(28)
            make.top.equalTo(self.view.snp.top).inset(160)
            make.height.equalTo(102)
        }
        
    }
}

