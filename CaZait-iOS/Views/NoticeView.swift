//
//  NoticeView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/01.
//

import UIKit
import SnapKit

class NoticeView: UIViewController, UIGestureRecognizerDelegate {
    
    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1) // 기존 배경 색상 유지
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    private let noticeTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = .white
        
        return textView
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
        
        setupNavigation()
        showTerms()
        view.addSubview(noticeTextView)
        
        self.noticeTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupNavigation() {
        self.title = "공지사항"
        
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
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showTerms() {
        let termsText =
            """
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            공지사항 내용입니다.
            """
        noticeTextView.text = termsText
    }
}
