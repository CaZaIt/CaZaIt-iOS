//
//  NotifyIdViewController.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/30.
//

import UIKit
import SnapKit

class NotifyIdViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var userId: String?
    
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
    
    private let idInfoView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
        return view
    }()
    
    private let idTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "회원님의 아이디는"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let idSubTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "입니다."
        label.numberOfLines = 1
        
        return label
    }()
    
    private let userIdLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 1
        
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.white, for: . normal)
        button.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
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
        userIdLabel.text = userId!
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func confirmButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupNavigation() {
        self.title = "아이디 찾기"
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
        
        view.addSubview(idInfoView)
        idInfoView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(69)
            make.leading.trailing.equalToSuperview().inset(52.5)
            make.height.equalTo(94.5)
        }
        
        idInfoView.addSubview(idTitleLabel)
        idTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(idInfoView.snp.top).offset(19.7)
            make.centerX.equalTo(idInfoView.snp.centerX)
        }
        
        idInfoView.addSubview(userIdLabel)
        userIdLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(idInfoView.snp.bottom).offset(-19.7)
            make.centerX.equalTo(idInfoView.snp.centerX).offset(-13)
        }
        
        idInfoView.addSubview(idSubTitleLabel)
        idSubTitleLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(idInfoView.snp.bottom).offset(-19.7)
            make.leading.equalTo(userIdLabel.snp.trailing).offset(13)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints{ make in
            make.top.equalTo(idInfoView.snp.bottom).offset(69)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(46)
        }
    }
}
