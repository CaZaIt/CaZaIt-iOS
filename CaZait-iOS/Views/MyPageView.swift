//
//  SwiftUIView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import UIKit
import SnapKit

class MyPageView: UIViewController{
    
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
    
    private let payView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.36, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let payLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "카자잇 페이"
        label.numberOfLines = 1
        return label
    }()
    
    private let paymoneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1,111"
        label.numberOfLines = 1
        return label
    }()
    
    private let paywonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "원"
        label.numberOfLines = 1
        return label
    }()
    
    private let mypagemenuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor(red: 1, green: 0.451, blue: 0.357, alpha: 0.31).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 4, height: 8)
        view.layer.shadowRadius = 14
        return view
    }()
    
    private let couponButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "money")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    
    private let paymentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    private let recentplaceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        return button
    }()
    
    
    
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let myConsumptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "나의 소비 그래프"
        label.numberOfLines = 1
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        view.addSubview(whiteView)
        whiteView.addSubview(pinkView)
        whiteView.addSubview(logoutLabel)
        whiteView.addSubview(payView)
        payView.addSubview(payLabel)
        payView.addSubview(paymoneyLabel)
        payView.addSubview(paywonLabel)
        whiteView.addSubview(mypagemenuView)
        whiteView.addSubview(horizontalLine)
        whiteView.addSubview(myConsumptionLabel)
        mypagemenuView.addSubview(couponButton)
        mypagemenuView.addSubview(paymentButton)
        mypagemenuView.addSubview(recentplaceButton)

        
        self.whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.whiteView.snp.top)
            make.height.equalTo(125)
        }
        
        self.logoutLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(39)
            make.top.equalTo(self.whiteView.snp.top).inset(46)
        }
        
        self.payView.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.logoutLabel.snp.bottom).offset(14)
            make.height.equalTo(102)
        }
        
        self.payLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.payView.snp.leading).inset(18)
            make.trailing.equalTo(self.payView.snp.trailing).inset(240)
            make.top.equalTo(self.payView.snp.top).inset(14)
            make.bottom.equalTo(self.payView.snp.bottom).inset(66)
        }
        
        self.paymoneyLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.payView.snp.leading).inset(200)
            make.trailing.equalTo(self.payView.snp.trailing).inset(55)
            make.top.equalTo(self.payView.snp.top).inset(46)
            make.bottom.equalTo(self.payView.snp.bottom).inset(4)
        }
        
        self.paywonLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.payView.snp.trailing).inset(26)
            make.bottom.equalTo(self.payView.snp.bottom).inset(6)
        }
        
        self.mypagemenuView.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.payView.snp.bottom).offset(15)
            make.bottom.equalTo(self.whiteView.snp.bottom).inset(358)
        }
        
        self.couponButton.snp.makeConstraints { make in
            make.leading.equalTo(self.mypagemenuView.snp.leading).inset(5)
            make.trailing.equalTo(self.mypagemenuView.snp.trailing).inset(230)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.height.equalTo(100)
        }
        self.paymentButton.snp.makeConstraints { make in
            make.leading.equalTo(self.couponButton.snp.trailing).inset(-10)
            make.trailing.equalTo(self.mypagemenuView.snp.trailing).inset(120)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.height.equalTo(100)
        }
        self.recentplaceButton.snp.makeConstraints { make in
            make.leading.equalTo(self.paymentButton.snp.trailing).inset(-10)
            make.trailing.equalTo(self.mypagemenuView.snp.trailing).inset(5)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.height.equalTo(100)
        }

        
        
        self.horizontalLine.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.mypagemenuView.snp.bottom).offset(30)
            make.height.equalTo(1)
        }
        
        self.myConsumptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(39)
            make.top.equalTo(self.horizontalLine.snp.bottom).offset(15)
            make.bottom.equalTo(self.whiteView.snp.bottom).inset(281)
        }
    }
    
    //상태표시줄 화이트색의 글씨로 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent // 밝은 배경색일 경우에는 .darkContent
        }
    

}

