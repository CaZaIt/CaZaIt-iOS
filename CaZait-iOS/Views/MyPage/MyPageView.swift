//
//  MyPageView_1.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/08/24.
//

import UIKit
import SnapKit

class MyPageView: UIViewController{
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.87, blue: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "로그인"
        label.numberOfLines = 1
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 1.0, green: 0.87, blue: 0.85, alpha: 1.0)
        button.setImage(UIImage(named: "arrow_circle_right"), for: .normal)
        return button
    }()
    
    private let payView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.36, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let payLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "카자잇 페이"
        label.numberOfLines = 1
        return label
    }()
    
    private let paymoneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "-,---"
        label.numberOfLines = 1
        return label
    }()
    
    private let paywonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "원"
        label.numberOfLines = 1
        return label
    }()
    
    private let mypagemenuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor(red: 1, green: 0.451, blue: 0.357, alpha: 0.31).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 4, height: 8)
        view.layer.shadowRadius = 14
        return view
    }()
    
    private let couponButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    private let couponImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "money")
        return imageView
    }()
    
    private let couponLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "쿠폰"
        label.numberOfLines = 1
        return label
    }()
    
    
    private let paymentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    private let paymentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "credit_card")
        return imageView
    }()
    
    private let paymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "결제 내역"
        label.numberOfLines = 1
        return label
    }()
    
    private let recentplaceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    private let recentplaceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "big_home")
        return imageView
    }()
    
    private let recentplaceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "최근 본 매장"
        label.numberOfLines = 1
        return label
    }()
    
    private let verticalLine_1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.36, alpha: 1.0)
        return view
    }()
    
    private let verticalLine_2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.36, alpha: 1.0)
        return view
    }()
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let dottedLineView: DottedLineView = {
        return DottedLineView()
    }()
    
    private let myConsumptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "나의 소비 그래프"
        label.numberOfLines = 1
        return label
    }()
    
    private let graphImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "commingsoon")
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.string(forKey: "userId") != nil {
            loginLabel.text = "로그아웃"
        }
        else {
            loginLabel.text = "로그인"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        view.addSubview(whiteView)
        whiteView.addSubview(pinkView)
        whiteView.addSubview(loginLabel)
        whiteView.addSubview(loginButton)
        whiteView.addSubview(payView)
        payView.addSubview(payLabel)
        payView.addSubview(paymoneyLabel)
        payView.addSubview(paywonLabel)
        whiteView.addSubview(mypagemenuView)
        mypagemenuView.addSubview(couponButton)
        mypagemenuView.addSubview(paymentButton)
        mypagemenuView.addSubview(recentplaceButton)
        mypagemenuView.addSubview(verticalLine_1)
        mypagemenuView.addSubview(verticalLine_2)
        couponButton.addSubview(couponImage)
        couponButton.addSubview(couponLabel)
        paymentButton.addSubview(paymentImage)
        paymentButton.addSubview(paymentLabel)
        recentplaceButton.addSubview(recentplaceImage)
        recentplaceButton.addSubview(recentplaceLabel)
        whiteView.addSubview(dottedLineView)
        whiteView.addSubview(myConsumptionLabel)
        whiteView.addSubview(graphImage)
        
        
        self.whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.whiteView.snp.top)
            // SE 기준 높이: 99
            let desiredHeightForSE: CGFloat = 510
            // iPhone 12 높이: UIScreen.main.bounds.height
            let screenHeightForIPhone12 = UIScreen.main.bounds.height
            // iPhone 12에서도 동일한 비율로 높이를 설정
            let pinkViewHeight = min(desiredHeightForSE, screenHeightForIPhone12) * 99 / desiredHeightForSE
            make.height.equalTo(pinkViewHeight)
            make.bottom.lessThanOrEqualTo(self.whiteView.snp.bottom)
        }
        
        self.loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(39)
            make.top.equalTo(self.whiteView.snp.top).inset(46)
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.leading.equalTo(self.loginLabel.snp.trailing).offset(2)
            make.top.equalTo(self.whiteView.snp.top).inset(44)
            
            // iPhone SE 기준 크기
            let desiredSizeForSE: CGFloat = 30
            
            // iPhone 12 크기: UIScreen.main.bounds.height
            let screenHeightForIPhone12 = UIScreen.main.bounds.height
            
            // iPhone 12에서도 동일한 비율로 크기를 설정
            let buttonSize = min(desiredSizeForSE, screenHeightForIPhone12) * 30 / desiredSizeForSE
            make.height.equalTo(buttonSize)
            make.width.equalTo(buttonSize)
        }
        
        self.payView.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.loginLabel.snp.bottom).offset(14)
            
            // iPhone SE 기준 크기
            let desiredHeightForSE: CGFloat = 102
            
            // iPhone 12 크기: UIScreen.main.bounds.height
            let screenHeightForIPhone12 = UIScreen.main.bounds.height
            
            // iPhone 12에서도 동일한 비율로 높이를 설정
            let payViewHeight = min(desiredHeightForSE, screenHeightForIPhone12) * 102 / desiredHeightForSE
            make.height.equalTo(payViewHeight)
        }
        
        self.payLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.payView.snp.leading).inset(18)
            //            make.trailing.equalTo(self.payView.snp.trailing).inset(240)
            make.top.equalTo(self.payView.snp.top).inset(14)
            make.bottom.equalTo(self.payView.snp.bottom).inset(66)
        }
        
        self.paymoneyLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.payView.snp.leading).inset(200)
            make.trailing.equalTo(self.payView.snp.trailing).inset(55)
            make.top.equalTo(self.payView.snp.top).inset(46)
            make.bottom.equalTo(self.payView.snp.bottom).inset(4)
        }
        
        self.paywonLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.payView.snp.trailing).inset(26)
            make.bottom.equalTo(self.payView.snp.bottom).inset(6)
        }
        
        self.mypagemenuView.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.payView.snp.bottom).offset(15)
            
            // iPhone SE 기준 높이: 350
            let desiredHeightForSE: CGFloat = 154
            
            // iPhone 12 높이: UIScreen.main.bounds.height
            let screenHeightForIPhone12 = UIScreen.main.bounds.height
            
            // iPhone 12에서도 동일한 비율로 높이를 설정
            let myPageMenuViewHeight = min(desiredHeightForSE, screenHeightForIPhone12) * 154 / desiredHeightForSE
            make.height.equalTo(myPageMenuViewHeight)
        }
        
        self.couponButton.snp.makeConstraints { make in
            make.leading.equalTo(self.mypagemenuView.snp.leading).inset(5)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.width.equalTo(self.mypagemenuView).dividedBy(3) // 1/3 폭
        }
        self.couponImage.snp.makeConstraints { make in
            make.leading.equalTo(self.couponButton.snp.leading).inset(27)
            make.trailing.equalTo(self.couponButton.snp.trailing).inset(27)
            make.top.equalTo(self.couponButton.snp.top).inset(38)
            make.bottom.equalTo(self.couponButton.snp.bottom).inset(72)
        }
        self.couponLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.couponButton.snp.leading).inset(35)
            make.trailing.equalTo(self.couponButton.snp.trailing).inset(35)
            make.top.equalTo(self.couponImage.snp.bottom).inset(-14)
        }
        self.paymentButton.snp.makeConstraints { make in
            make.leading.equalTo(self.couponButton.snp.trailing)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.width.equalTo(self.mypagemenuView).dividedBy(3) // 1/3 폭
        }
        self.paymentImage.snp.makeConstraints { make in
            make.leading.equalTo(self.paymentButton.snp.leading).inset(27)
            make.trailing.equalTo(self.paymentButton.snp.trailing).inset(27)
            make.top.equalTo(self.paymentButton.snp.top).inset(38)
            make.bottom.equalTo(self.paymentButton.snp.bottom).inset(72)
        }
        self.paymentLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.paymentButton.snp.leading).inset(15)
            make.trailing.equalTo(self.paymentButton.snp.trailing).inset(15)
            make.top.equalTo(self.paymentImage.snp.bottom).inset(-14)
        }
        self.recentplaceButton.snp.makeConstraints { make in
            make.leading.equalTo(self.paymentButton.snp.trailing)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(5)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(5)
            make.width.equalTo(self.mypagemenuView).dividedBy(3) // 1/3 폭
        }
        self.recentplaceImage.snp.makeConstraints { make in
            make.leading.equalTo(self.recentplaceButton.snp.leading).inset(33)
            make.trailing.equalTo(self.recentplaceButton.snp.trailing).inset(33)
            make.top.equalTo(self.recentplaceButton.snp.top).inset(38)
            make.bottom.equalTo(self.recentplaceButton.snp.bottom).inset(72)
        }
        self.recentplaceLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.recentplaceButton.snp.leading).inset(15)
            make.trailing.equalTo(self.recentplaceButton.snp.trailing).inset(15)
            make.top.equalTo(self.recentplaceImage.snp.bottom).inset(-14)
        }
        
        self.verticalLine_1.snp.makeConstraints { make in
            make.centerX.equalTo(self.couponButton.snp.trailing)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(10)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(10)
            make.width.equalTo(1)
        }
        
        self.verticalLine_2.snp.makeConstraints { make in
            make.centerX.equalTo(self.paymentButton.snp.trailing)
            make.top.equalTo(self.mypagemenuView.snp.top).inset(10)
            make.bottom.equalTo(self.mypagemenuView.snp.bottom).inset(10)
            make.width.equalTo(1)
        }
        
        self.dottedLineView.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(28)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(28)
            make.top.equalTo(self.mypagemenuView.snp.bottom).offset(30)
            make.height.equalTo(1)
        }
        
        self.myConsumptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).inset(39)
            make.top.equalTo(self.dottedLineView.snp.bottom).offset(15)
        }
        
        self.graphImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 가운데 정렬
            make.top.equalTo(self.myConsumptionLabel.snp.bottom).offset(22) // 기존의 top 설정 유지
            make.width.height.equalTo(150) // 너비와 높이를 100으로 고정
            
            // iPhone SE 기준 크기
            let desiredSizeForSE: CGFloat = 150
            
            // iPhone 12 크기: UIScreen.main.bounds.height
            let screenHeightForIPhone12 = UIScreen.main.bounds.height
            
            // iPhone 12에서도 동일한 비율로 크기를 설정
            let imageSize = min(desiredSizeForSE, screenHeightForIPhone12) * 150 / desiredSizeForSE
            make.width.height.equalTo(imageSize)
        }
        
        couponButton.addTarget(self, action:#selector(buttonClicked_1), for: .touchUpInside)
        paymentButton.addTarget(self, action:#selector(buttonClicked_2), for: .touchUpInside)
        recentplaceButton.addTarget(self, action: #selector(buttonClicked_3), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(buttonClicked_4), for: .touchUpInside)
    }
    //상태표시줄 화이트색의 글씨로 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경색일 경우에는 .darkContent
    }
    
    @objc func buttonClicked_1(_ sender: UIButton) {
        let alertController = UIAlertController(title: "서비스 준비중입니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // OK 버튼을 클릭하면 실행될 코드
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonClicked_2(_ sender: UIButton) {
        let alertController = UIAlertController(title: "서비스 준비중입니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // OK 버튼을 클릭하면 실행될 코드
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonClicked_3(_ sender: UIButton) {
        // RecentCafeView 인스턴스 생성
        let recentCafeView = RecentCafeView()
        // 내비게이션 스택으로 RecentCafeView를 푸시
        if UserDefaults.standard.data(forKey: "recentCafes") != nil {
            self.navigationController?.pushViewController(recentCafeView, animated: true)
        }
        else {
            let alertController = UIAlertController(title: "최근 본 매장이 없습니다.", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // OK 버튼을 클릭하면 실행될 코드
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func buttonClicked_4(_ sender: UIButton) {
        // RecentCafeView 인스턴스 생성
        
        if (loginLabel.text == "로그인") {
            let loginView = LoginView()
            // 내비게이션 스택으로 RecentCafeView를 푸시
            self.navigationController?.pushViewController(loginView, animated: true)
        }
        
        if (loginLabel.text == "로그아웃") {
            KeyChain.delete(key: "accessToken")
            KeyChain.delete(key: "refreshToken")
            
            UserDefaults.standard.removeObject(forKey: "userId")

            let alertController = UIAlertController(title: "로그아웃되었습니다.", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // OK 버튼을 클릭하면 실행될 코드
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            loginLabel.text = "로그인"
            
        }
        
        
    }
}


class DottedLineView: UIView {
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1.5
        layer.lineDashPattern = [8, 8]
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.addSublayer(shapeLayer)
        // Autolayout을 위해 추가
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 레이어의 경로 설정
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        shapeLayer.path = path.cgPath
    }
}
