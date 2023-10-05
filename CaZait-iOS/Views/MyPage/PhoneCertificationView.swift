//
//  PhoneCertificationView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/08/16.
//

import Foundation
import UIKit

class PhoneCertificationView: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate{
    
    var flag: Int = 0 //문자인증 완료 변수(초기값은 0)
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
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
    
    private let numberValidationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red // You can choose the appropriate color
        label.textAlignment = .left
        label.numberOfLines = 0 // Allow multiple lines for longer error messages
        return label
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
    private let certifyNextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
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
        phonenumberButton.isEnabled = false
        phonenumberButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 바 타이틀 설정
        self.title = "핸드폰인증"
        
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
        
        phonenumberField.delegate = self
        
        self.view.addSubview(pinkView)
        self.pinkView.addSubview(phonenumberLabel)
        self.pinkView.addSubview(phonenumberField)
        self.pinkView.addSubview(numberValidationLabel)
        self.pinkView.addSubview(phonenumberButton)
        self.pinkView.addSubview(certifyField)
        self.pinkView.addSubview(certifyButton)
        self.pinkView.addSubview(certifyNextButton)
        
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.phonenumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
            make.top.equalTo(self.pinkView.safeAreaLayoutGuide.snp.top).inset(41)
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
        self.numberValidationLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(40)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.phonenumberField.snp.bottom).offset(2)
        }
        self.certifyField.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(30)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(134)
            make.top.equalTo(self.numberValidationLabel.snp.bottom).offset(20)
            make.height.equalTo(43)
        }
        self.certifyButton.snp.makeConstraints { make in
            make.leading.equalTo(self.phonenumberField.snp.trailing).offset(10)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(23)
            make.top.equalTo(self.numberValidationLabel.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        self.certifyNextButton.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(122)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(122)
            make.bottom.equalTo(self.pinkView.snp.bottom).inset(220)
            make.height.equalTo(46)
        }
        
        
        //중복 확인 버튼 클릭시 이벤트 추가
        certifyNextButton.addTarget(self, action:#selector(nextView), for: .touchUpInside)
        phonenumberButton.addTarget(self, action:#selector(messageSend), for: .touchUpInside)
        certifyButton.addTarget(self, action:#selector(messageVerify), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == phonenumberField {
                // 입력된 텍스트와 새로 입력된 문자를 합쳐서 전체 텍스트를 가져옴
                if let text = textField.text, let range = Range(range, in: text) {
                    let updatedText = text.replacingCharacters(in: range, with: string)
                    
                    // 유효성 검사: 010으로 시작하고 11자리 숫자인지 확인
                    let phoneNumberRegex = "^010[0-9]{8}$"
                    let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
                    let isPhoneNumberValid = phoneNumberTest.evaluate(with: updatedText)
                    
                    if isPhoneNumberValid {
                        numberValidationLabel.isHidden = false
                        numberValidationLabel.text = "가능한 번호입니다."
                        numberValidationLabel.textColor = .blue // 유효한 경우 녹색으로 표시
                        phonenumberButton.backgroundColor = UIColor(r: 255, g: 115, b: 91)
                        phonenumberButton.isEnabled = true
                    } else {
                        numberValidationLabel.isHidden = false
                        numberValidationLabel.text = "유효하지 않는 번호입니다."
                        numberValidationLabel.textColor = .red // 유효하지 않은 경우 빨간색으로 표시
                        phonenumberButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        phonenumberButton.isEnabled = false
                    }
                }
                // 입력된 텍스트가 없으면 라벨을 다시 숨김
                if textField.text?.isEmpty == true {
                    numberValidationLabel.isHidden = true
                }
            }
            return true
        }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    

    
    @objc func nextView(_ sender: UIButton) {
        if flag == 1 {
            let signupView = SignupView()
            signupView.phoneNumber = phonenumberField.text
            self.navigationController?.pushViewController(signupView, animated: true)
        } else {
            let alert = UIAlertController(title: "핸드폰 인증 후 가능합니다.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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

// 중복확인 및 회원가입 통신을 위한 클래스 확장
extension PhoneCertificationView {
    
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
                // 발송 성공 시에 버튼의 타이틀을 "재전송"으로 변경
                self.phonenumberButton.setTitle("재전송", for: .normal)
                self.phonenumberField.isUserInteractionEnabled = false
                
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
            default:
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
                self.certifyField.isHidden = false
                print(data)
                
                self.flag = 1  // "success" 시에 flag 값을 1로 변경합니다.
                
            case .requestErr(let err):
                print(err)
            case .pathErr:
                let alert = UIAlertController(title: "인증에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("pathErr")
            case .serverErr:
                print("serverErr")
            default:
                let alert = UIAlertController(title: "인증에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
}
