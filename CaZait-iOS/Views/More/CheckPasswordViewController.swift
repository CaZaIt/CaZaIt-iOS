//
//  CheckPasswordViewController.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/16.
//

import UIKit
import SnapKit

class CheckPasswordViewController: UIViewController, UIGestureRecognizerDelegate {

    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        
        return view
    }()
    
    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "비밀번호 확인"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        textField.isSecureTextEntry = true // 비밀번호 입력 시 보이지 않도록 설정
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        
        return textField
    }()
    
    private let passwordExpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = .red
        label.textAlignment = .left
        label.text = "입력하신 비밀번호가 올바르지 않습니다."
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.setTitleColor(UIColor.white, for: . normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.isEnabled = false
        button.layer.cornerRadius = 20 // 버튼의 코너를 둥글게 설정
        
        // 버튼이 눌렸을 때 호출되는 액션을 설정합니다.
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
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
        passwordTextField.delegate = self
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupNavigation() {
        self.title = "계정관리"
        //손가락 옆으로 미는 제스쳐 작동
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    @objc private func confirmButtonTapped() {
        if let password = passwordTextField.text {
            checkPassword(password: password)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkPassword(password: String) {
        CheckPasswordService.shared.getCheckPasswordInfo(password: password) { response in
            
            switch response {
                
            case .success(let data):
                guard let listData = data as? CheckPasswordResponse else {return}
                self.passwordExpLabel.isHidden = true
                let vc = AccountManagementVC()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                self.passwordExpLabel.isHidden = false
            }
        }
    }
    
    func setupLayout() {
        view.addSubview(pinkView)
        pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(42)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(43)
        }
        
        view.addSubview(passwordExpLabel)
        passwordExpLabel.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(42)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
    }
}

extension CheckPasswordViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            confirmButton.isEnabled = false
        } else {
            confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            confirmButton.isEnabled = true
        }
    }
    
}
