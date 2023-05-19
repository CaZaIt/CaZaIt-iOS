//
//  LoginView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/15.
//

import Foundation

import UIKit

class LoginView: UIViewController{
    
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    private let cazaitLogo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "cazait_logo")
        return logo
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "LOGIN"
        label.numberOfLines = 1
        return label
    }()
    
    private let idtextField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 22
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    private let passwordtextField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 22
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 바 타이틀 설정
        self.title = "로그인"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        //손가락 옆으로 미는 제스쳐 작동
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        self.view.addSubview(pinkView)
        self.pinkView.addSubview(cazaitLogo)
        self.pinkView.addSubview(loginLabel)
        self.pinkView.addSubview(idtextField)
        self.pinkView.addSubview(passwordtextField)
        self.pinkView.addSubview(loginButton)
        self.pinkView.addSubview(signupButton)
        
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.cazaitLogo.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(125)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(125)
            make.top.equalTo(self.pinkView.safeAreaLayoutGuide.snp.top).inset(80)
        }
        self.loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(58)
            make.top.equalTo(self.pinkView.safeAreaLayoutGuide.snp.top).inset(248)
        }
        self.idtextField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(40)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(40)
            make.top.equalTo(self.loginLabel.snp.bottom).offset(7)
            make.height.equalTo(45)
        }
        self.passwordtextField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(40)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(40)
            make.top.equalTo(self.idtextField.snp.bottom).offset(6)
            make.height.equalTo(45)
        }
        self.loginButton.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(40)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(40)
            make.top.equalTo(self.passwordtextField.snp.bottom).offset(27)
            make.height.equalTo(45)
        }
        self.signupButton.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(140)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(140)
            make.top.equalTo(self.loginButton.snp.bottom).offset(9)
            make.height.equalTo(45)
        }
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}


extension LoginView: UIGestureRecognizerDelegate { }