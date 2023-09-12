//
//  ChangeNewPasswordVC.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/26.
//

import UIKit
import SnapKit

class ChangeNewPasswordVC: UIViewController {

    var userFieldId : String?
    var userId : String?
    
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
    
    private let userIdTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "아이디"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let userIdLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 1
        
        return label
    }()
    
    private let passwordTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "새 비밀번호"
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
    
    private let againPasswordTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "새 비밀번호 확인"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let passwordCheckLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        label.textAlignment = .left
        label.text = ""
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()
    
    private let againPasswordTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.placeholder = "비밀번호를 한 번 더 입력해주세요"
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        textField.isSecureTextEntry = true // 비밀번호 입력 시 보이지 않도록 설정
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        
        return textField
    }()
    
    private let passwordExpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        label.textAlignment = .left
        label.text = "입력하신 비밀번호가 일치하지 않습니다."
        label.isHidden = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("변경하기", for: .normal)
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
        
        // 다른 부분을 탭할 때 키보드 숨기기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .black
        passwordTextField.delegate = self
        againPasswordTextField.delegate = self
        userIdLabel.text = userFieldId
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func confirmButtonTapped() {
        guard let passwordText = passwordTextField.text, let againPasswordText = againPasswordTextField.text else { return }
        if passwordText == againPasswordText {
            checkPassword(password: passwordText)
        } else {
            passwordExpLabel.isHidden = false
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkPassword(password: String) {
        guard let userId = userId else { return }
        NewPasswordService.shared.changeNewPassword(userId: userId, password: password) { response in
            
            switch response {
                
            case .success(let data):
                guard let listData = data as? NewPasswordResponse else {return}
                let alert = UIAlertController(title: "새로운 비밀번호 설정이 완료되었습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            default:
                let alert = UIAlertController(title: "비밀번호 변경에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setupNavigation() {
        self.title = "새 비밀번호 설정"
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
    
    func validatePassword(realtimeText: String) -> Bool{
        let minLength = 8
        let maxLength = 16
        
        let lowercaseLetterPattern = ".*[a-z]+.*"
        let uppercaseLetterPattern = ".*[A-Z]+.*"
        let numberPattern = ".*\\d+.*"
        let specialCharacterPattern = ".*[$@!%*#?&.]+.*"
        
        let lowercaseLetterRegex = try? NSRegularExpression(pattern: lowercaseLetterPattern, options: [])
        let uppercaseLetterRegex = try? NSRegularExpression(pattern: uppercaseLetterPattern, options: [])
        let numberRegex = try? NSRegularExpression(pattern: numberPattern, options: [])
        let specialCharacterRegex = try? NSRegularExpression(pattern: specialCharacterPattern, options: [])
        
        let containsLowercaseLetter = lowercaseLetterRegex?.matches(in: realtimeText, options: [], range: NSRange(location: 0, length: realtimeText.utf16.count)).count ?? 0 > 0
        let containsUppercaseLetter = uppercaseLetterRegex?.matches(in: realtimeText, options: [], range: NSRange(location: 0, length: realtimeText.utf16.count)).count ?? 0 > 0
        let containsNumber = numberRegex?.matches(in: realtimeText, options: [], range: NSRange(location: 0, length: realtimeText.utf16.count)).count ?? 0 > 0
        let containsSpecialCharacter = specialCharacterRegex?.matches(in: realtimeText, options: [], range: NSRange(location: 0, length: realtimeText.utf16.count)).count ?? 0 > 0
        
        if realtimeText.count < minLength || realtimeText.count > maxLength {
            passwordCheckLabel.text = "최소 8자 이상, 최대 16자 이하로 입력해주세요."
            passwordCheckLabel.textColor = UIColor.red
            return false
        } else if !containsLowercaseLetter || !containsUppercaseLetter || !containsNumber || !containsSpecialCharacter {
            passwordCheckLabel.text = "적어도 하나의 대문자, 소문자, 숫자, 특수문자가 포함되어야 합니다."
            passwordCheckLabel.textColor = UIColor.red
            return false
        } else {
            passwordCheckLabel.text = "가능한 비밀번호입니다."
            passwordCheckLabel.textColor = UIColor.blue
            return true
        }
    }
    
    func setupLayout() {
        
        view.addSubview(pinkView)
        pinkView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(userIdTitleLabel)
        userIdTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(41)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(userIdLabel)
        userIdLabel.snp.makeConstraints{ make in
            make.top.equalTo(userIdTitleLabel.snp.bottom).offset(3)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(userIdLabel.snp.bottom).offset(28)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(43)
        }
        
        view.addSubview(passwordCheckLabel)
        passwordCheckLabel.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(39)
        }
        
        view.addSubview(againPasswordTitleLabel)
        againPasswordTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(passwordCheckLabel.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(againPasswordTextField)
        againPasswordTextField.snp.makeConstraints{ make in
            make.top.equalTo(againPasswordTitleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(43)
        }
        
        view.addSubview(passwordExpLabel)
        passwordExpLabel.snp.makeConstraints{ make in
            make.top.equalTo(againPasswordTextField.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ make in
            make.top.equalTo(againPasswordTextField.snp.bottom).offset(227)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
    }
}


extension ChangeNewPasswordVC: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        //입력하신 비밀번호가 일치하지 않습니다. 입력할땐 제거하기.
        passwordExpLabel.isHidden = true
        
        if let passwordText = passwordTextField.text {
            passwordCheckLabel.isHidden = false //비밀번호 정규식 알림 메시지
            if validatePassword(realtimeText: passwordText) {
                if againPasswordTextField.text?.isEmpty == true { //새 비밀번호 확인도 입력했을 경우
                    confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                    confirmButton.isEnabled = false
                } else { //새 비밀번호 확인을 입력하지 않았을 때
                    confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    confirmButton.isEnabled = true
                }
            }
        }
    }
    
}

extension ChangeNewPasswordVC: UIGestureRecognizerDelegate {
    
    // 다른 부분을 탭할 때 키보드 숨기기
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
