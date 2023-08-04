//
//  TermsView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/07/26.
//

import Foundation
import UIKit
import SnapKit

class TermsView: UIViewController, UIGestureRecognizerDelegate{
    
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    private let allagreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "약관 전체동의"
        label.numberOfLines = 1
        return label
    }()
    
    private let essentialLabel_1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "필수"
        label.numberOfLines = 1
        return label
    }()
    
    private let placeAgreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "위치정보 기반 서비스 이용약관"
        label.numberOfLines = 1
        return label
    }()
    
    private let detailLabel_1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(r: 255, g: 115, b: 91)
        label.textAlignment = .center
        label.text = "위치정보 기반 서비스 이용약관 내용 보기"
        label.numberOfLines = 1
        return label
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(r: 255, g: 115, b: 91)
        return button
    }()
    
    // 체크박스 버튼
    private let allcheckBoxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    // 체크박스 버튼
    private let checkBoxButton_1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    // 체크박스 상태를 저장할 변수 (기본은 선택되지 않은 상태로 초기화)
    private var isCheckBoxChecked = false
    
    private let dottedLineView: DottedLineView = {
        return DottedLineView()
    }()
    
    //다음 버튼
    private let nextButton: UIButton = {
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 바 타이틀 설정
        self.title = "약관동의"
        
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
        self.pinkView.addSubview(allcheckBoxButton)
        self.pinkView.addSubview(nextButton)
        self.pinkView.addSubview(allagreeLabel)
        self.pinkView.addSubview(dottedLineView)
        self.pinkView.addSubview(essentialLabel_1)
        self.pinkView.addSubview(placeAgreeLabel)
        self.pinkView.addSubview(checkBoxButton_1)
        self.pinkView.addSubview(detailLabel_1)
        self.pinkView.addSubview(rightArrowButton)
        
        
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.allagreeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.pinkView.snp.top).inset(48)
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
        }
        
        self.allcheckBoxButton.snp.makeConstraints { make in
            make.top.equalTo(self.pinkView.snp.top).inset(45)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(35)
            make.width.height.equalTo(30)
        }
        
        self.dottedLineView.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(28)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(28)
            make.top.equalTo(self.allagreeLabel.snp.bottom).offset(30)
            make.height.equalTo(1)
        }
        
        self.essentialLabel_1.snp.makeConstraints { make in
            make.top.equalTo(self.dottedLineView.snp.bottom).offset(25)
            make.leading.equalTo(self.pinkView.snp.leading).inset(39)
        }
        
        self.placeAgreeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dottedLineView.snp.bottom).offset(25)
            make.leading.equalTo(self.essentialLabel_1.snp.trailing).offset(16)
        }
        
        self.checkBoxButton_1.snp.makeConstraints { make in
            make.top.equalTo(self.dottedLineView.snp.bottom).offset(22)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(35)
            make.width.height.equalTo(30)
        }
        
        self.detailLabel_1.snp.makeConstraints { make in
            make.top.equalTo(self.placeAgreeLabel.snp.bottom).offset(1)
            make.leading.equalTo(self.essentialLabel_1.snp.trailing).offset(16)
        }
        
        self.rightArrowButton.snp.makeConstraints { make in
            make.top.equalTo(self.placeAgreeLabel.snp.bottom).offset(3)
            make.leading.equalTo(self.detailLabel_1.snp.trailing).offset(3)
            make.width.height.equalTo(10)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.leading.equalTo(self.pinkView.snp.leading).inset(122)
            make.trailing.equalTo(self.pinkView.snp.trailing).inset(122)
            make.bottom.equalTo(self.pinkView.snp.bottom).inset(220)
            make.height.equalTo(46)
        }
        
        nextButton.addTarget(self, action:#selector(signupClicked), for: .touchUpInside)
        // 버튼에 액션 추가
        allcheckBoxButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        checkBoxButton_1.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 체크박스 버튼을 탭할 때 호출되는 액션 메서드
    @objc func checkBoxTapped(sender: UIButton) {
        // 현재 상태를 반전시킴
        isCheckBoxChecked = !isCheckBoxChecked
        sender.isSelected = isCheckBoxChecked
    }
    
    @objc func signupClicked(_ sender: UIButton) {
        // RecentCafeView 인스턴스 생성
        let signupView = SignupView()
        // 내비게이션 스택으로 RecentCafeView를 푸시
        self.navigationController?.pushViewController(signupView, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
