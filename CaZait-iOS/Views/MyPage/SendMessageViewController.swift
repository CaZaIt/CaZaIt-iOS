//
//  SendMessageViewController.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/26.
//

import UIKit
import SnapKit

class SendMessageViewController: UIViewController, UIGestureRecognizerDelegate {

    var userId : String?
    var userFieldId : String?
    var mode : String = ""
    private var timer: Timer?
    private var remainingTime: TimeInterval = 180 // 3분
    
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
    
    private let phoneTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "휴대폰 인증"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.placeholder = "휴대전화 번호를 입력해주세요"
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        textField.keyboardType = .numberPad
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        
        return textField
    }()
    
    private let autNumTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.placeholder = "인증번호 입력"
        textField.setPlaceholder(color: UIColor(r: 181, g: 181, b: 181))
        textField.keyboardType = .numberPad
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        
        return textField
    }()
    
    private let sendAutNumBcutton: UIButton = {
        let button = UIButton()
        
        button.setTitle("인증번호 전송", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(UIColor.white, for: . normal)
        button.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 0.5)
        button.isEnabled = false
        button.layer.cornerRadius = 20 // 버튼의 코너를 둥글게 설정
        
        // 버튼이 눌렸을 때 호출되는 액션을 설정합니다.
        button.addTarget(self, action: #selector(sendAutNumButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let PhoneNumExpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        label.textAlignment = .left
        label.text = ""
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        label.textAlignment = .left
        label.text = ""
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("인증하기", for: .normal)
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

        view.backgroundColor = .black
        phoneNumberTextField.delegate = self
        autNumTextField.delegate = self
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @objc private func sendAutNumButtonTapped() {
        guard let phoneNumberText = phoneNumberTextField.text else { return }
        
        if mode == "findId" {
            CheckUserPhoneService.shared.getCheckUserPhone(phoneNumber: phoneNumberText, isExist: "true") { response in
                switch response {
                case .success(let data):
                    guard let data = data as? UserPhoneCheckResponse else { return }
                    self.sendMessage(phoneNumber: phoneNumberText)
                default:
                    self.PhoneNumExpLabel.textColor = .red
                    self.PhoneNumExpLabel.text = "입력하신 휴대번호는 등록되지 않은 번호입니다."
                    self.PhoneNumExpLabel.isHidden = false
                    self.confirmButton.isEnabled = false
                    self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                }
            }
        } else if mode == "findPassword" {
            CheckUserInfoService.shared.getCheckUserInfo(userId: userId!, phoneNumber: phoneNumberText) { response in
                switch response {
                case .success(let data):
                    guard let data = data as? UserInfoCheckResponse else { return }
                    self.userFieldId = data.data.accountName //새 비밀번호 변경을 할 때 유저 필드 id저장
                    self.sendMessage(phoneNumber: phoneNumberText)
                default:
                    self.PhoneNumExpLabel.textColor = .red
                    self.PhoneNumExpLabel.text = "입력하신 ID와 일치하지 않는 번호입니다."
                    self.PhoneNumExpLabel.isHidden = false
                    self.confirmButton.isEnabled = false
                    self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                }
            }
        } else if mode == "signUp" {
            CheckUserPhoneService.shared.getCheckUserPhone(phoneNumber: phoneNumberText, isExist: "false") { response in
                switch response {
                case .success(let data):
                    guard let data = data as? UserPhoneCheckResponse else { return }
                    self.sendMessage(phoneNumber: phoneNumberText)
                default:
                    self.PhoneNumExpLabel.textColor = .red
                    self.PhoneNumExpLabel.text = "입력하신 휴대번호는 등록된 번호입니다."
                    self.PhoneNumExpLabel.isHidden = false
                    self.confirmButton.isEnabled = false
                    self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                }
            }
        }
    }
    
    @objc func updateTime() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
        }
    }
    
    func updateTimerLabel() {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func sendMessage(phoneNumber: String) {
        //timer 작동
        self.remainingTime = 180
        timeLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        messageSendService.shared.messageSend(recipientPhoneNumber: phoneNumber) { response in
            switch response {
            case .success(let data):
                guard let data = data as? MessageSendResponse else { return }
                self.confirmButton.isEnabled = true
                self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                let alert = UIAlertController(title: "인증번호를 전송했습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    self.autNumTextField.becomeFirstResponder()
                }))
                self.present(alert, animated: true, completion: nil)
                self.sendAutNumBcutton.setTitle("재전송", for: .normal)
                
            default:
                let alert = UIAlertController(title: "인증할 수 없는 번호 입니다", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    @objc private func confirmButtonTapped() {
        guard let recipientPhoneNumber = phoneNumberTextField.text else { return }
        guard let verificationCode = autNumTextField.text else { return }
        
        messageVerifyService.shared.messageVerify(recipientPhoneNumber: recipientPhoneNumber, verificationCode: verificationCode) { response in
            switch response {
            case .success(let data):
                //ChangeNewPasswordVC
                guard let data = data as? MessageVerifyResponse else { return }
                let alert = UIAlertController(title: "인증에 성공했습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    if self.mode == "findId" {
                        self.findId(phoneNumber: recipientPhoneNumber)
                    } else if self.mode == "findPassword" {
                        let vc = ChangeNewPasswordVC()
                        vc.userId = self.userId
                        vc.userFieldId = self.userFieldId
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if self.mode == "signUp" {
                        let vc = SignupView()
                        vc.phoneNumber = recipientPhoneNumber
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            default:
                let alert = UIAlertController(title: "인증에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func findId(phoneNumber: String) {
        NotifyIdService.shared.getIdInfo(phoneNumber: phoneNumber) { response in
            switch response {
            case .success(let data):
                //ChangeNewPasswordVC
                guard let data = data as? NotifyIdResponse else { return }
                let vc = NotifyIdViewController()
                vc.userId = data.data.accountName

                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let alert = UIAlertController(title: "통신에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
    
    func validateInput(_ input: String) -> Bool {
        let regex = "^010[0-9]{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }

    func setupNavigation() {
        if mode == "findId" {
            self.title = "아이디 찾기"
        } else if mode == "findPassword" {
            self.title = "비밀번호 찾기"
        } else if mode == "signUp" {
            self.title = "회원가입"
        }
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

    func setupLayout() {
        view.addSubview(pinkView)
        pinkView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(phoneTitleLabel)
        phoneTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(41)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints{ make in
            make.top.equalTo(phoneTitleLabel.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-134)
            make.height.equalTo(43)
        }
        
        view.addSubview(PhoneNumExpLabel)
        PhoneNumExpLabel.snp.makeConstraints{ make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(39)
        }
        
        view.addSubview(sendAutNumBcutton)
        sendAutNumBcutton.snp.makeConstraints{ make in
            make.centerY.equalTo(phoneNumberTextField.snp.centerY)
            make.leading.equalTo(phoneNumberTextField.snp.trailing).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-23)
            make.height.equalTo(43)
        }
        
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(sendAutNumBcutton.snp.centerX)
            make.top.equalTo(sendAutNumBcutton.snp.bottom).offset(1)
        }
        
        view.addSubview(autNumTextField)
        autNumTextField.snp.makeConstraints{ make in
            make.top.equalTo(PhoneNumExpLabel.snp.bottom).offset(7)
            make.leading.equalTo(phoneNumberTextField.snp.leading)
            make.trailing.equalTo(sendAutNumBcutton.snp.trailing)
            make.height.equalTo(43)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-261)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
    }
}


extension SendMessageViewController: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if let nickNameText = phoneNumberTextField.text {
            if validateInput(nickNameText) {
                PhoneNumExpLabel.text = ""
                PhoneNumExpLabel.isHidden = true
                sendAutNumBcutton.isEnabled = true
                sendAutNumBcutton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
            } else {
                PhoneNumExpLabel.textColor = .red
                PhoneNumExpLabel.text = "-를 제외한 010으로 시작하는 11자리의 번호를 입력해주세요"
                PhoneNumExpLabel.isHidden = false
                sendAutNumBcutton.isEnabled = false
                sendAutNumBcutton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 0.5)
            }
        }
        
        if textField == phoneNumberTextField {
            self.confirmButton.isEnabled = false
            self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
}
