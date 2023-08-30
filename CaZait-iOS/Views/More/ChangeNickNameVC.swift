//
//  ChangeNickNameVC.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/23.
//

import UIKit
import SnapKit

class ChangeNickNameVC: UIViewController, UIGestureRecognizerDelegate {

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
    
    private let nickNameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "닉네임"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.placeholder = "새로운 닉네임을 입력해주세요"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        
        return textField
    }()
    
    private let duplicateCheckButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(UIColor.white, for: . normal)
        button.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 0.5)
        button.isEnabled = false
        button.layer.cornerRadius = 20 // 버튼의 코너를 둥글게 설정
        
        // 버튼이 눌렸을 때 호출되는 액션을 설정합니다.
        button.addTarget(self, action: #selector(duplicateCheckButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let nickNameExpLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .red
        label.textAlignment = .left
        label.text = ""
        label.isHidden = true
        label.numberOfLines = 0
        
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

        view.backgroundColor = .black
        nickNameTextField.delegate = self
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @objc private func duplicateCheckButtonTapped() {
        guard let nickNameText = nickNameTextField.text else { return }
        print(nickNameText)
        nicknameCheckService.shared.nicknamecheck(nickname: nickNameText, isExist: "false") { response in
            switch response {
            case .success(let data):
                guard let data = data as? NicknameCheckResponse else { return }
                self.nickNameExpLabel.textColor = .blue
                self.nickNameExpLabel.text = "사용 가능한 닉네임 입니다."
                self.nickNameExpLabel.isHidden = false
                self.confirmButton.isEnabled = true
                self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            default:
                self.nickNameExpLabel.textColor = .red
                self.nickNameExpLabel.text = "이미 사용 중인 닉네임 입니다."
                self.nickNameExpLabel.isHidden = false
                self.confirmButton.isEnabled = false
                self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            }
        }
    }
    
    @objc private func confirmButtonTapped() {
        guard let nickNameText = nickNameTextField.text else { return }
        ChangeNickNameService.shared.getChangeNickNameInfo(nickName: nickNameText) { response in
            
            switch response {
                
            case .success(let data):
                guard let listData = data as? ChangeNickNameResponse else {return}
                let alert = UIAlertController(title: "\(nickNameText)로 닉네임 변경이 완료되었습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            default:
                let alert = UIAlertController(title: "닉네임 변경에 실패하였습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateInput(_ input: String) -> Bool {
        let regex = "^[a-zA-Z가-힣]{3,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }

    func setupNavigation() {
        self.title = "닉네임 변경"
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
        
        view.addSubview(nickNameTitleLabel)
        nickNameTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(41)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        view.addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTitleLabel.snp.bottom).offset(7)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-134)
            make.height.equalTo(43)
        }
        
        view.addSubview(nickNameExpLabel)
        nickNameExpLabel.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(39)
        }
        
        view.addSubview(duplicateCheckButton)
        duplicateCheckButton.snp.makeConstraints{ make in
            make.centerY.equalTo(nickNameTextField.snp.centerY)
            make.leading.equalTo(nickNameTextField.snp.trailing).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-23)
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


extension ChangeNickNameVC: UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        self.confirmButton.isEnabled = false
        self.confirmButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        if let nickNameText = textField.text {
            if validateInput(nickNameText) {
                nickNameExpLabel.isHidden = true
                duplicateCheckButton.isEnabled = true
                duplicateCheckButton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
            } else {
                nickNameExpLabel.textColor = .red
                nickNameExpLabel.text = "한글과 영문으로만 구성하여 3~15자 이내로 작성해주세요."
                nickNameExpLabel.isHidden = false
                duplicateCheckButton.isEnabled = false
                duplicateCheckButton.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 0.5)
            }
        }
    }
    
}
