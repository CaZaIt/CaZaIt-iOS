//
//  SignupView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/23.
//

import Foundation
import UIKit

class SignupView: UIViewController{
    
    var phoneNumber : String?
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    //아이디 Label
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "닉네임"
        label.numberOfLines = 1
        return label
    }()
    
    //아이디 TextField
    private let nicknameField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "예: kazait123"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    
    
    //아이디 중복확인 버튼
    private let nicknameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(r: 255, g: 115, b: 91)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(r: 141, g: 96, b: 96)
        label.textAlignment = .left
        label.text = "6자 이상의 영문 혹은 영문과 숫자를 조합"
        label.numberOfLines = 1
        return label
    }()
    
    //비밀번호 Label
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "비밀번호"
        label.numberOfLines = 1
        return label
    }()
    
    //비밀번호 TextField
    private let pwField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    //비밀번호 확인 Label
    private let pwLabel_1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "비밀번호 확인"
        label.numberOfLines = 1
        return label
    }()
    
    //비밀번호 확인 TextField
    private let pwField_1: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호를 한 번 더 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    //아이디 Label
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "아이디"
        label.numberOfLines = 1
        return label
    }()
    
    //이메일 TextLabel
    private let idField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "예: kazait123"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    //이메일 중복확인 버튼
    private let idButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(r: 255, g: 115, b: 91)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let phonenumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "핸드폰번호"
        label.numberOfLines = 1
        return label
    }()
    
    private let phonenumberField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "예: 01012345678"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    private let phonenumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("인증번호발송", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(r: 255, g: 115, b: 91)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let certifyField: InsetTextField = {
        let textField = InsetTextField()
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "예: 123456"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = false
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.textColor = UIColor(r: 93, g: 36, b: 36)
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        return textField
    }()
    
    private let certifyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("인증확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(r: 255, g: 115, b: 91)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    //가입하기 버튼
    private let joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
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
        
        idField.delegate = self
        pwField.delegate = self
        
        // 네비게이션 바 타이틀 설정
        self.title = "회원가입"
        
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
        
        // 다른 부분을 탭할 때 키보드 숨기기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
        self.view.addSubview(pinkView)
        self.pinkView.addSubview(idLabel)
        self.pinkView.addSubview(idField)
        self.pinkView.addSubview(idButton)
//        self.pinkView.addSubview(descriptionLabel)
        self.pinkView.addSubview(pwLabel)
        self.pinkView.addSubview(pwField)
        self.pinkView.addSubview(pwLabel_1)
        self.pinkView.addSubview(pwField_1)
        self.pinkView.addSubview(nicknameLabel)
        self.pinkView.addSubview(nicknameField)
        self.pinkView.addSubview(nicknameButton)
        self.pinkView.addSubview(phonenumberLabel)
        self.pinkView.addSubview(phonenumberField)
        self.pinkView.addSubview(phonenumberButton)
        self.pinkView.addSubview(certifyField)
        self.pinkView.addSubview(certifyButton)
        self.pinkView.addSubview(joinButton)
        
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.idLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.pinkView.safeAreaLayoutGuide.snp.top).inset(41)
        }
        self.idField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(134)
            make.top.equalTo(self.idLabel.snp.bottom).offset(7)
            make.height.equalTo(43)
        }
        self.idButton.snp.makeConstraints { make in
            make.leading.equalTo(self.idField.snp.trailing).offset(10)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.idLabel.snp.bottom).offset(7)
            make.height.equalTo(44)
        }
        self.pwLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.idField.snp.bottom).offset(20)
        }
        self.pwField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.pwLabel.snp.bottom).offset(7)
            make.height.equalTo(43)
        }
        self.pwLabel_1.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.pwField.snp.bottom).offset(20)
        }
        self.pwField_1.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.pwLabel_1.snp.bottom).offset(7)
            make.height.equalTo(43)
        }
        self.nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.pwField_1.snp.bottom).offset(20)
        }
        self.nicknameField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(134)
            make.top.equalTo(self.nicknameLabel.snp.bottom).offset(7)
            make.height.equalTo(43)
        }
        self.nicknameButton.snp.makeConstraints { make in
            make.leading.equalTo(self.nicknameField.snp.trailing).offset(10)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.nicknameLabel.snp.bottom).offset(7)
            make.height.equalTo(44)
        }
        self.phonenumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.nicknameField.snp.bottom).offset(20)
        }
        self.phonenumberField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(134)
            make.top.equalTo(self.phonenumberLabel.snp.bottom).offset(7)
            make.height.equalTo(43)
        }
        self.phonenumberButton.snp.makeConstraints { make in
            make.leading.equalTo(self.phonenumberField.snp.trailing).offset(10)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.phonenumberLabel.snp.bottom).offset(7)
            make.height.equalTo(44)
        }
        self.certifyField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(134)
            make.top.equalTo(self.phonenumberField.snp.bottom).offset(20)
            make.height.equalTo(43)
        }
        self.certifyButton.snp.makeConstraints { make in
            make.leading.equalTo(self.phonenumberField.snp.trailing).offset(10)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.phonenumberField.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        
        
        self.joinButton.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(122)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(122)
            make.top.equalTo(self.certifyField.snp.bottom).offset(40)
            make.height.equalTo(46)
        }
        
        
        //중복 확인 버튼 클릭시 이벤트 추가
        idButton.addTarget(self, action:#selector(idCheck), for: .touchUpInside)
        nicknameButton.addTarget(self, action:#selector(nicknameCheck), for: .touchUpInside)
        joinButton.addTarget(self, action:#selector(SignUp), for: .touchUpInside)
        phonenumberButton.addTarget(self, action:#selector(messageSend), for: .touchUpInside)
        certifyButton.addTarget(self, action:#selector(messageVerify), for: .touchUpInside)
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func idCheck() {
        idcheck()
    }
    
    @objc func nicknameCheck() {
        nicknamecheck()
    }
    
    @objc func SignUp() {
        signup()
    }
    
    @objc func messageSend() {
        messagesend()
    }
    
    @objc func messageVerify() {
        messageverify()
    }
    
    // 다른 부분을 탭할 때 키보드 숨기기
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// 손가락 제스처 기능 확장
extension SignupView: UIGestureRecognizerDelegate { }


// 중복확인 및 회원가입 통신을 위한 클래스 확장
extension SignupView {
    
    //아이디 중복확인
    func idcheck() {
        
        guard let accountName = idField.text else { return }
        
        
        idCheckService.shared.idcheck(accountName: accountName) { response in
            switch response {
            case .success(let data):
                guard let data = data as? IdCheckResponse else { return }
                let alert = UIAlertController(title: data.message, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(data)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "사용할 수 없는 아이디 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                let alert = UIAlertController(title: "사용할 수 없는 아이디 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    //닉네임 중복확인
    func nicknamecheck() {
        
        guard let nickname = nicknameField.text else { return }
        
        
        nicknameCheckService.shared.nicknamecheck(nickname: nickname) { response in
            switch response {
            case .success(let data):
                guard let data = data as? NicknameCheckResponse else { return }
                let alert = UIAlertController(title: "사용가능한 닉네임입니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(data)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "사용할 수 없는 닉네임 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                let alert = UIAlertController(title: "사용할 수 없는 닉네임 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    //인증번호 발송
    func messagesend() {
        
        guard let recipientPhoneNumber = phonenumberField.text else { return }
        
        
        messageSendService.shared.messageSend(recipientPhoneNumber: recipientPhoneNumber) { response in
            switch response {
            case .success(let data):
                guard let data = data as? MessageSendResponse else { return }
                let alert = UIAlertController(title: data.message, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(data)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "인증할 수 없는 번호 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                let alert = UIAlertController(title: "인증할 수 없는 번호 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    //인증번호 발송
    func messageverify() {
        
        guard let recipientPhoneNumber = phonenumberField.text else { return }
        guard let verificationCode = certifyField.text else { return }
        
        
        messageVerifyService.shared.messageVerify(recipientPhoneNumber: recipientPhoneNumber, verificationCode: verificationCode) { response in
            switch response {
            case .success(let data):
                guard let data = data as? MessageVerifyResponse else { return }
                let alert = UIAlertController(title: data.message, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(data)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "인증에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                let alert = UIAlertController(title: "인증에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    //가입하기
    func signup() {
        
        guard let nickname_sign = nicknameField.text else { return }
        guard let password_sign = pwField.text else { return }
        guard let accountName_sign = idField.text else { return }
        guard let phoneNumber_sign = phonenumberField.text else { return }
        
        
        signupService.shared.signup(accountName: accountName_sign, password: password_sign, nickname: nickname_sign,phoneNumber: phoneNumber_sign) { response in
            switch response {
            case .success(let data):
                guard let data = data as? SignupResponse else { return }
                let alert = UIAlertController(title: data.message, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print(data)
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "회원가입에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                let alert = UIAlertController(title: "회원가입에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
}

extension SignupView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == idField {
            // Concatenate the current text with the replacing string
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            validateID(realtimeText: newText)
        }
        if textField == pwField {
            // Concatenate the current text with the replacing string
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            validatePassword(realtimeText: newText)
        }
        return true
    }
}

extension SignupView {
    func validateID(realtimeText: String) {
        let idPattern = "^[a-z]+[0-9]*$" // Pattern for IDs starting with lowercase letters and ending with numbers
        let minIDLength = 8 // Minimum length for the ID
        let maxIDLength = 20 // Maximum length for the ID
        
        let idRegex = try? NSRegularExpression(pattern: idPattern, options: [])
        let matches = idRegex?.matches(in: realtimeText, options: [], range: NSRange(location: 0, length: realtimeText.utf16.count))
        
        if realtimeText.count >= minIDLength, realtimeText.count <= maxIDLength, matches?.count == 0 {
            print("Invalid ID: 영문 소문자로 시작하고 숫자로 끝나야 합니다.")
        } else if realtimeText.count < minIDLength {
            print("Invalid ID: 최소 6자 이상이어야 합니다.")
        } else if realtimeText.count > maxIDLength {
            print("Invalid ID: 최대 20자까지만 입력 가능합니다.")
        } else {
            print("가능한 아이디입니다.")
        }
    }
    func validatePassword(realtimeText: String) {
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
                print("Invalid password: 최소 8자 이상, 최대 16자 이하로 입력해주세요.")
            } else if !containsLowercaseLetter || !containsUppercaseLetter || !containsNumber || !containsSpecialCharacter {
                print("Invalid password: 적어도 하나의 대문자, 소문자, 숫자, 특수문자가 포함되어야 합니다.")
            } else {
                print("Valid password")
            }
        }
}